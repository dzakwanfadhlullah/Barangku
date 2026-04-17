import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBackground,
      appBar: AppBar(
        backgroundColor: AppColors.warmSurface,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.olive700.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.package, color: AppColors.olive700, size: 24),
            ),
            const SizedBox(width: 12),
            Text(
              'Barangku',
              style: AppTextStyles.h2.copyWith(color: AppColors.olive900),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search, color: AppColors.olive700),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Halo, Budi!', style: AppTextStyles.h1),
                      const SizedBox(height: 4),
                      Text(
                        'Toko Berkah Jaya',
                        style: AppTextStyles.bodyMd.copyWith(color: AppColors.warmMutedGray),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.sage300.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.wifiOff, size: 14, color: AppColors.olive700),
                        const SizedBox(width: 6),
                        Text(
                          'MODE LOKAL',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.olive700,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Summary Grid
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      icon: LucideIcons.layers,
                      title: 'Total Barang',
                      value: '1,248',
                      iconColor: AppColors.olive700,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: _buildSummaryCard(
                      icon: LucideIcons.alertTriangle,
                      title: 'Stok Menipis',
                      value: '12',
                      iconColor: AppColors.error,
                      valueColor: AppColors.error,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.m),
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      icon: LucideIcons.fileText,
                      title: 'Transaksi',
                      value: '24',
                      subtitle: 'Hari Ini',
                      iconColor: AppColors.olive700,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: _buildSummaryCard(
                      icon: LucideIcons.cloudLightning,
                      title: 'Status Sync',
                      value: 'Aman',
                      subtitle: '2 mnt lalu',
                      iconColor: AppColors.sage600,
                      isStatus: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Aksi Cepat
              _buildSectionTitle('AKSI CEPAT', actionText: ''),
              const SizedBox(height: AppSpacing.m),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAction(
                    icon: LucideIcons.plus,
                    label: 'Tambah\nBarang',
                    isPrimary: true,
                    onTap: () => context.push('/barang/tambah'),
                  ),
                  _buildQuickAction(
                    icon: LucideIcons.arrowDownToLine,
                    label: 'Stok\nMasuk',
                    onTap: () {},
                  ),
                  _buildQuickAction(
                    icon: LucideIcons.arrowUpFromLine,
                    label: 'Stok\nKeluar',
                    onTap: () {},
                  ),
                  _buildQuickAction(
                    icon: LucideIcons.scanLine,
                    label: 'Scan\nBarcode',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Perlu Perhatian
              _buildSectionTitle('PERLU PERHATIAN', actionText: 'Lihat Semua'),
              const SizedBox(height: AppSpacing.m),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.softCharcoal.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildAttentionItem(
                      name: 'Minyak Goreng 2L',
                      stockInfo: '2 botol',
                    ),
                    Divider(height: 1, color: AppColors.neutralDivider.withValues(alpha: 0.3)),
                    _buildAttentionItem(
                      name: 'Beras Pandan Wangi 5kg',
                      stockInfo: '1 karung',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Aktivitas Terbaru
              _buildSectionTitle('AKTIVITAS TERBARU', actionText: ''),
              const SizedBox(height: AppSpacing.m),
              _buildActivityItem('Stok Masuk: Gula Pasir +50', 'Hari ini, 09:42 WIB', AppColors.olive700),
              const SizedBox(height: AppSpacing.m),
              _buildActivityItem('Update Harga: Indomie Goreng', 'Kemarin, 16:20 WIB', AppColors.sage600),
              
              const SizedBox(height: AppSpacing.xxxl), // space for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String value,
    String? subtitle,
    required Color iconColor,
    Color? valueColor,
    bool isStatus = false,
  }) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.softCharcoal.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 8),
              if (!isStatus)
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.warmMutedGray,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (isStatus)
                Text(
                  title,
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.warmMutedGray,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isStatus)
                    Container(
                      margin: const EdgeInsets.only(right: 6, bottom: 6),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.sage600,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Text(
                    value,
                    style: AppTextStyles.h1.copyWith(
                      color: valueColor ?? AppColors.softCharcoal,
                      fontSize: 28,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        subtitle,
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.warmMutedGray,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              if (!isStatus && subtitle == null)
                Text(
                  title,
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.warmMutedGray,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {String actionText = ''}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.bodySm.copyWith(
            color: AppColors.warmMutedGray,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            fontSize: 11,
          ),
        ),
        if (actionText.isNotEmpty)
          Text(
            actionText,
            style: AppTextStyles.bodySm.copyWith(
              color: AppColors.olive700,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    bool isPrimary = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isPrimary ? AppColors.olive700 : Colors.white,
              shape: BoxShape.circle,
              boxShadow: isPrimary
                  ? [
                      BoxShadow(
                        color: AppColors.olive700.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: AppColors.softCharcoal.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Icon(
              icon,
              color: isPrimary ? Colors.white : AppColors.olive700,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySm.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttentionItem({required String name, required String stockInfo}) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.m),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.warmSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(LucideIcons.package, color: AppColors.warmMutedGray),
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.h3.copyWith(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text('Sisa: ', style: AppTextStyles.bodySm.copyWith(color: AppColors.warmMutedGray)),
                    Text(stockInfo, style: AppTextStyles.bodySm.copyWith(color: AppColors.error, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.warmBackground,
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.plus, size: 16, color: AppColors.olive700),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String text, String time, Color dotColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: dotColor.withValues(alpha: 0.3),
                blurRadius: 6,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: AppTextStyles.bodySm.copyWith(color: AppColors.warmMutedGray),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
