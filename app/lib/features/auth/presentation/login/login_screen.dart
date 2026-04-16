import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackButton: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.xl),

            // Top Branding
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.olive700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  LucideIcons.package,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            Text(
              'Masuk',
              textAlign: TextAlign.center,
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Subtle localized trust badge
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.sage300.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(LucideIcons.shieldCheck, size: 16, color: AppColors.olive700),
                    const SizedBox(width: AppSpacing.s),
                    Text(
                      'Data tersedia di perangkat ini',
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.olive700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Form Fields
            const AppTextField(
              label: 'Username',
              hintText: 'Masukkan username',
            ),
            const SizedBox(height: AppSpacing.l),
            const AppTextField(
              label: 'Kata sandi',
              isPassword: true,
              hintText: 'Masukkan kata sandi',
            ),
            const SizedBox(height: AppSpacing.s),
            
            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.push('/forgot-password');
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Lupa kata sandi?',
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.olive700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Login Button
            AppButton(
              text: 'Masuk',
              onPressed: () {
                // Placeholder for actual login logic (navigation UI only for now)
              },
            ),
            const SizedBox(height: AppSpacing.l),
            
            // Register link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belum punya akun?',
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.warmMutedGray),
                ),
                TextButton(
                  onPressed: () {
                    context.push('/register');
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: Text(
                    'Buat akun lokal',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.olive700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
