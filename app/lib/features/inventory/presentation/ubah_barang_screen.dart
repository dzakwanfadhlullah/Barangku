import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../data/models/item_model.dart';
import '../providers/inventory_provider.dart';

class UbahBarangScreen extends HookConsumerWidget {
  final ItemModel item;
  
  const UbahBarangScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: item.name);
    final skuController = useTextEditingController(text: item.sku ?? '');
    final categoryController = useTextEditingController(text: item.category ?? '');
    final stockController = useTextEditingController(text: item.initialStock.toString());
    final unitController = useTextEditingController(text: item.unit ?? '');
    
    // We parse double to avoid .0 if it's an integer value conceptually
    final priceStr = item.price.truncate() == item.price ? item.price.toInt().toString() : item.price.toString();
    final priceController = useTextEditingController(text: priceStr);
    
    final descController = useTextEditingController(text: item.description ?? '');
    
    final isLoading = useState(false);

    return AppScaffold(
      title: 'Ubah Data Barang',
      showBackButton: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Preview (Existing Image)
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.warmSurface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.neutralDivider.withValues(alpha: 0.5), width: 1),
                    ),
                    child: const Icon(LucideIcons.image, color: AppColors.warmMutedGray, size: 32),
                  ),
                  Positioned(
                    bottom: -8,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.olive700,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(LucideIcons.camera, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            AppTextField(
              controller: nameController,
              label: 'Nama Barang',
            ),
            const SizedBox(height: AppSpacing.l),
            
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: skuController,
                    label: 'SKU / Barcode',
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: AppTextField(
                    controller: categoryController,
                    label: 'Kategori',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.l),

            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: stockController,
                    label: 'Sisa Stok',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: AppTextField(
                    controller: unitController,
                    label: 'Satuan',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.l),

            AppTextField(
              controller: priceController,
              label: 'Harga Jual',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppSpacing.l),

            AppTextField(
              controller: descController,
              label: 'Deskripsi',
            ),
            
            const SizedBox(height: AppSpacing.xxxl),
            
            AppButton(
              text: isLoading.value ? 'Menyimpan...' : 'Simpan Perubahan',
              icon: isLoading.value ? null : const Icon(LucideIcons.save, size: 20),
              onPressed: isLoading.value
                  ? null
                  : () async {
                      if (nameController.text.trim().isEmpty || stockController.text.trim().isEmpty || priceController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Nama, stok, dan harga harus diisi!')),
                        );
                        return;
                      }

                      final stock = int.tryParse(stockController.text.trim()) ?? 0;
                      final price = double.tryParse(priceController.text.trim()) ?? 0.0;

                      final updatedItem = item.copyWith(
                        name: nameController.text.trim(),
                        sku: skuController.text.trim(),
                        category: categoryController.text.trim(),
                        initialStock: stock,
                        unit: unitController.text.trim(),
                        price: price,
                        description: descController.text.trim(),
                      );

                      isLoading.value = true;
                      await ref.read(inventoryProvider.notifier).updateItem(updatedItem);

                      if (context.mounted) {
                        isLoading.value = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Perubahan berhasil disimpan!')),
                        );
                        context.pop(); // kembali ke detail
                      }
                    },
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
