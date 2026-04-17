import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';

class DetailBarangScreen extends StatelessWidget {
  const DetailBarangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Detail Barang',
      showBackButton: true,
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.moreVertical, color: AppColors.olive700),
          onPressed: () {},
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Placeholder
            Container(
              height: 240,
              width: double.infinity,
              color: AppColors.warmSurface,
              child: const Icon(LucideIcons.image, size: 64, color: AppColors.warmMutedGray),
            ),
            
            Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Minyak Goreng 2L',
                          style: AppTextStyles.h1.copyWith(fontSize: 24),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.sage300.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'Sembako',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.olive700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Text(
                    'Rp 34.000',
                    style: AppTextStyles.h2.copyWith(color: AppColors.olive700),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  
                  // Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          icon: LucideIcons.barcode,
                          label: 'SKU',
                          value: 'SKU-001A',
                        ),
                      ),
                      const SizedBox(width: AppSpacing.m),
                      Expanded(
                        child: _buildInfoCard(
                          icon: LucideIcons.package,
                          label: 'Stok Tersedia',
                          value: '15 Botol',
                          isValueAlert: false, // If stock was low, make it true
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Detail Tambahan
                  Text(
                    'Informasi Tambahan',
                    style: AppTextStyles.h3,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  _buildDetailRow('Deskripsi', 'Minyak goreng kemasan pouch plastik ukuran 2 Liter merk Tropical murni asli berkualitas tinggi.'),
                  _buildDetailRow('Kondisi Barang', 'Baru'),
                  _buildDetailRow('Lokasi Rak', 'Rak A - Baris 2'),
                  _buildDetailRow('Distributor', 'PT. Bina Pangan Sejahtera'),
                  
                  const SizedBox(height: AppSpacing.xxxl),
                  
                  // Actions
                  AppButton(
                    text: 'Ubah Data',
                    icon: const Icon(LucideIcons.edit2, size: 18),
                    onPressed: () => context.push('/barang/ubah'),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  AppButton(
                    text: 'Hapus Barang',
                    type: AppButtonType.text,
                    icon: const Icon(LucideIcons.trash2, size: 18, color: AppColors.error),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    bool isValueAlert = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutralDivider.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.warmMutedGray),
          const SizedBox(height: AppSpacing.m),
          Text(
            label,
            style: AppTextStyles.bodySm.copyWith(color: AppColors.warmMutedGray),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.bodyMd.copyWith(
              fontWeight: FontWeight.w700,
              color: isValueAlert ? AppColors.error : AppColors.softCharcoal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.warmMutedGray),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMd.copyWith(
                color: AppColors.softCharcoal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
