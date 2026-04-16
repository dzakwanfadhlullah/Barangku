import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackButton: true,
      title: 'Pengaturan Akun',
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l, vertical: AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Summary Section
            Center(
              child: Column(
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: AppColors.sage300.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Icon(
                      LucideIcons.user,
                      size: 40,
                      color: AppColors.olive700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  Text(
                    'IDENTITAS',
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.olive700,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'budi_jaya',
                    style: AppTextStyles.h2.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.sage300.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.smartphone, size: 16, color: AppColors.olive700),
                        const SizedBox(width: AppSpacing.s),
                        Text(
                          'Akun lokal aktif di perangkat ini.',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.olive700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Settings Group
            _buildGroupTitle('KEAMANAN & AKSES'),
            _buildMenuCard([
              _buildMenuItem(
                icon: LucideIcons.keyRound,
                title: 'Ubah kata sandi',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: LucideIcons.helpCircle,
                title: 'Ubah pertanyaan keamanan',
                onTap: () {},
                showBorder: false,
              ),
            ]),
            const SizedBox(height: AppSpacing.l),

            // Danger Zone
            _buildMenuCard([
              _buildMenuItem(
                icon: LucideIcons.logOut,
                title: 'Keluar',
                titleColor: AppColors.error,
                iconColor: AppColors.error,
                iconBgColor: AppColors.error.withValues(alpha: 0.1),
                hideArrow: true,
                showBorder: false,
                onTap: () => context.go('/login'),
              ),
            ]),
            const SizedBox(height: AppSpacing.xxl),

            // Context Card: Kerahasiaan Terjamin
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.olive700,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.olive700.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.m),
                      Text(
                        'Kerahasiaan Terjamin',
                        style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Text(
                    'Data inventaris Anda disimpan secara lokal dan dienkripsi. Kami tidak pernah mengunggah informasi barang ke server tanpa persetujuan Anda.',
                    style: AppTextStyles.bodySm.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.olive700,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(
                      'Pelajari Enkripsi',
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.olive700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title,
        style: AppTextStyles.bodySm.copyWith(
          color: AppColors.warmMutedGray.withValues(alpha: 0.8),
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
            color: AppColors.softCharcoal.withValues(alpha: 0.02),
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
              ? Border(bottom: BorderSide(color: AppColors.neutralDivider.withValues(alpha: 0.5)))
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor ?? AppColors.sage300.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor ?? AppColors.olive700, size: 20),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.h3.copyWith(
                  color: titleColor ?? AppColors.softCharcoal,
                  fontSize: 16,
                ),
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
