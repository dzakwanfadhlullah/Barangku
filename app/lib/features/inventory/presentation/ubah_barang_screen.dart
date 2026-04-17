import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class UbahBarangScreen extends StatefulWidget {
  const UbahBarangScreen({super.key});

  @override
  State<UbahBarangScreen> createState() => _UbahBarangScreenState();
}

class _UbahBarangScreenState extends State<UbahBarangScreen> {
  late TextEditingController _nameController;
  late TextEditingController _skuController;
  late TextEditingController _categoryController;
  late TextEditingController _stockController;
  late TextEditingController _unitController;
  late TextEditingController _priceController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    // Simulate prefilled data for edit screen
    _nameController = TextEditingController(text: 'Minyak Goreng 2L');
    _skuController = TextEditingController(text: 'SKU-001A');
    _categoryController = TextEditingController(text: 'Sembako');
    _stockController = TextEditingController(text: '15');
    _unitController = TextEditingController(text: 'Botol');
    _priceController = TextEditingController(text: '34000');
    _descController = TextEditingController(text: 'Minyak goreng kemasan pouch plastik ukuran 2 Liter merk Tropical murni asli berkualitas tinggi.');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _categoryController.dispose();
    _stockController.dispose();
    _unitController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              controller: _nameController,
              label: 'Nama Barang',
            ),
            const SizedBox(height: AppSpacing.l),
            
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _skuController,
                    label: 'SKU / Barcode',
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: AppTextField(
                    controller: _categoryController,
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
                    controller: _stockController,
                    label: 'Sisa Stok',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: AppTextField(
                    controller: _unitController,
                    label: 'Satuan',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.l),

            AppTextField(
              controller: _priceController,
              label: 'Harga Jual',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppSpacing.l),

            AppTextField(
              controller: _descController,
              label: 'Deskripsi',
            ),
            
            const SizedBox(height: AppSpacing.xxxl),
            
            AppButton(
              text: 'Simpan Perubahan',
              icon: const Icon(LucideIcons.save, size: 20),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
