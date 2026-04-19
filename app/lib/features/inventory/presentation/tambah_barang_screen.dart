import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/inventory_provider.dart';

class TambahBarangScreen extends HookConsumerWidget {
  const TambahBarangScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final skuController = useTextEditingController();
    final categoryController = useTextEditingController();
    final stockController = useTextEditingController();
    final unitController = useTextEditingController();
    final priceController = useTextEditingController();
    final descController = useTextEditingController();
    
    final isLoading = useState(false);

    return AppScaffold(
      title: 'Tambah Barang',
      showBackButton: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Picker
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.warmSurface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.neutralDivider.withValues(alpha: 0.5), width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LucideIcons.camera, color: AppColors.warmMutedGray, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      'Tambah Foto',
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.warmMutedGray,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            AppTextField(
              controller: nameController,
              label: 'Nama Barang',
              hintText: 'Cth: Minyak Goreng 2L',
            ),
            const SizedBox(height: AppSpacing.l),
            
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: skuController,
                    label: 'SKU / Barcode',
                    hintText: 'Scan / ketik SKU',
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: AppTextField(
                    controller: categoryController,
                    label: 'Kategori',
                    hintText: 'Pilih kategori',
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
                    label: 'Stok Awal',
                    hintText: '0',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: AppTextField(
                    controller: unitController,
                    label: 'Satuan',
                    hintText: 'Pcs, Kg, L...',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.l),

            AppTextField(
              controller: priceController,
              label: 'Harga Jual',
              hintText: 'Ribuan (Cth: 15000)',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppSpacing.l),

            AppTextField(
              controller: descController,
              label: 'Deskripsi (Opsional)',
              hintText: 'Tambahkan detail barang',
            ),
            
            const SizedBox(height: AppSpacing.xxxl),
            
            AppButton(
              text: isLoading.value ? 'Menyimpan...' : 'Simpan Barang',
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

                      isLoading.value = true;
                      await ref.read(inventoryProvider.notifier).addItem(
                        name: nameController.text.trim(),
                        sku: skuController.text.trim(),
                        category: categoryController.text.trim(),
                        initialStock: stock,
                        unit: unitController.text.trim(),
                        price: price,
                        description: descController.text.trim(),
                      );

                      if (context.mounted) {
                        isLoading.value = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Barang berhasil disimpan!')),
                        );
                        context.pop();
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
