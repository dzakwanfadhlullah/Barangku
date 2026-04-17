import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class TambahBarangScreen extends StatelessWidget {
  const TambahBarangScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

            const AppTextField(
              label: 'Nama Barang',
              hintText: 'Cth: Minyak Goreng 2L',
            ),
            const SizedBox(height: AppSpacing.l),
            
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: 'SKU / Barcode',
                    hintText: 'Scan / ketik SKU',
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: AppTextField(
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
                    label: 'Stok Awal',
                    hintText: '0',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: AppTextField(
                    label: 'Satuan',
                    hintText: 'Pcs, Kg, L...',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.l),

            const AppTextField(
              label: 'Harga Jual',
              hintText: 'Rp 0',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppSpacing.l),

            const AppTextField(
              label: 'Deskripsi (Opsional)',
              hintText: 'Tambahkan detail barang',
            ),
            
            const SizedBox(height: AppSpacing.xxxl),
            
            AppButton(
              text: 'Simpan Barang',
              icon: const Icon(LucideIcons.save, size: 20),
              onPressed: () {
                // Return to previous screen pretending we saved this
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
