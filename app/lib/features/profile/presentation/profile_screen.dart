import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBackground,
      appBar: AppBar(
        backgroundColor: AppColors.warmSurface,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 8,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.olive700),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: Text(
          'Profil',
          style: AppTextStyles.h3.copyWith(color: AppColors.olive700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l, vertical: AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Identity Section
              Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.softCharcoal.withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: AppColors.olive700,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'TJ',
                        style: AppTextStyles.h1.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.m),
                    Text('Toko Berkah Jaya', style: AppTextStyles.h2),
                    const SizedBox(height: 4),
                    Text(
                      'Budi Santoso',
                      style: AppTextStyles.bodyMd.copyWith(color: AppColors.warmMutedGray),
                    ),
                    const SizedBox(height: AppSpacing.m),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.sage300.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        'PREMIUM PLAN',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.olive700,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.l),

              // Statistics Quick Glance
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: LucideIcons.package,
                      title: 'TOTAL BARANG',
                      value: '1,248',
                      iconColor: AppColors.olive700,
                      bgColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: _buildStatCard(
                      icon: LucideIcons.trendingUp,
                      title: 'TREND BULAN INI',
                      value: '+12.4%',
                      iconColor: Colors.white,
                      bgColor: AppColors.olive700,
                      valueColor: Colors.white,
                      titleColor: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Group: Utama
              _buildGroupTitle('UTAMA'),
              _buildMenuCard([
                _buildMenuItem(
                  icon: LucideIcons.store,
                  title: 'Profil Usaha',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: LucideIcons.user,
                  title: 'Pengaturan Akun',
                  onTap: () => context.push('/profile/settings'),
                  showBorder: false,
                ),
              ]),
              const SizedBox(height: AppSpacing.l),

              // Group: Data & Sistem
              _buildGroupTitle('DATA & SISTEM'),
              _buildMenuCard([
                _buildMenuItem(
                  icon: LucideIcons.refreshCw,
                  title: 'Sinkronisasi',
                  subtitle: 'Terakhir: 5 menit yang lalu',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: LucideIcons.database,
                  title: 'Cadangan & Data Lokal',
                  onTap: () {},
                  showBorder: false,
                ),
              ]),
              const SizedBox(height: AppSpacing.l),

              // Group: Informasi
              _buildGroupTitle('INFORMASI'),
              _buildMenuCard([
                _buildMenuItem(
                  icon: LucideIcons.info,
                  title: 'Tentang Aplikasi',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: LucideIcons.logOut,
                  title: 'Keluar',
                  titleColor: AppColors.error,
                  iconColor: AppColors.error,
                  iconBgColor: AppColors.error.withOpacity(0.1),
                  showBorder: false,
                  hideArrow: true,
                  onTap: () => context.go('/login'),
                ),
              ]),
              
              const SizedBox(height: AppSpacing.xl),
              Center(
                child: Text(
                  'Barangku v2.4.0 (Stable)',
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.warmMutedGray.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl), // space for bottom nav
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3, 
        onTap: (index) {
          // Placeholder behavior
        },
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
    required Color bgColor,
    Color? valueColor,
    Color? titleColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (bgColor == Colors.white)
            BoxShadow(
              color: AppColors.softCharcoal.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: AppSpacing.l),
          Text(
            title,
            style: AppTextStyles.bodySm.copyWith(
              color: titleColor ?? AppColors.warmMutedGray,
              fontWeight: FontWeight.w700,
              fontSize: 10,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTextStyles.h2.copyWith(
              color: valueColor ?? AppColors.softCharcoal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title,
        style: AppTextStyles.bodySm.copyWith(
          color: AppColors.warmMutedGray.withOpacity(0.8),
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.softCharcoal.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? titleColor,
    Color? iconColor,
    Color? iconBgColor,
    bool showBorder = true,
    bool hideArrow = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l, vertical: AppSpacing.m),
        decoration: BoxDecoration(
          border: showBorder
              ? Border(bottom: BorderSide(color: AppColors.neutralDivider.withOpacity(0.5)))
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor ?? AppColors.sage300.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor ?? AppColors.olive700, size: 20),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.h3.copyWith(
                      color: titleColor ?? AppColors.softCharcoal,
                      fontSize: 16,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySm.copyWith(color: AppColors.warmMutedGray),
                    ),
                  ]
                ],
              ),
            ),
            if (!hideArrow)
              const Icon(LucideIcons.chevronRight, color: AppColors.warmMutedGray, size: 20),
          ],
        ),
      ),
    );
  }
}
