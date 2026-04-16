import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/widgets/app_button.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmSurface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xxl),
              
              // Illustration placeholder (using a large clean icon for now)
              Expanded(
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.warmBackground,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.sage300.withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        LucideIcons.boxes,
                        size: 80,
                        color: AppColors.olive500,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: AppSpacing.xl),
              
              // Copywriting section
              Text(
                'Catat stok lebih rapi',
                textAlign: TextAlign.center,
                style: AppTextStyles.h1,
              ),
              const SizedBox(height: AppSpacing.m),
              Text(
                'Aplikasi inventori minim disrupsi, didesain untuk pencatatan luring (offline) langsung di perangkat Anda tanpa perlu koneksi terus-menerus.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLg.copyWith(
                  color: AppColors.warmMutedGray,
                ),
              ),
              
              const SizedBox(height: AppSpacing.xxxl),
              
              // Actions
              AppButton(
                text: 'Buat Akun Lokal',
                onPressed: () {
                  context.push('/register');
                },
              ),
              const SizedBox(height: AppSpacing.s),
              AppButton(
                type: AppButtonType.text,
                text: 'Masuk',
                onPressed: () {
                  context.push('/login');
                },
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
