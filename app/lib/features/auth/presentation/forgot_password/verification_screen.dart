import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_spacing.dart';
import '../../../../../theme/app_text_styles.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackButton: true,
      title: 'Verifikasi Akun',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Safe conceptual hero banner (thesis ready, no random web images)
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.sage300.withOpacity(0.15),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.neutralDivider.withOpacity(0.5)),
              ),
              child: const Center(
                child: Icon(
                  LucideIcons.shieldCheck,
                  size: 48,
                  color: AppColors.olive500,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.l),

            // Account Summary Card
            Container(
              padding: const EdgeInsets.all(AppSpacing.l),
              decoration: BoxDecoration(
                color: AppColors.warmSurface,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.softCharcoal.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.olive700.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(LucideIcons.user, color: AppColors.olive700),
                  ),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AKUN TERDAFTAR',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.warmMutedGray,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Andi Wijaya', // Mock data
                          style: AppTextStyles.h3.copyWith(fontSize: 16),
                        ),
                        Text(
                          'andi.w@example.com',
                          style: AppTextStyles.bodyMd.copyWith(color: AppColors.warmMutedGray),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            Text(
              'Pertanyaan Keamanan',
              style: AppTextStyles.h2.copyWith(fontSize: 22, color: AppColors.olive700),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Gunakan pertanyaan pemulihan yang telah Anda atur sebelumnya untuk memverifikasi identitas Anda.',
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.warmMutedGray, height: 1.5),
            ),
            const SizedBox(height: AppSpacing.l),

            // Question Box
            Container(
              padding: const EdgeInsets.all(AppSpacing.l),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.neutralDivider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'PERTANYAAN',
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.warmMutedGray,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s),
                  Text(
                    'Apa nama hewan peliharaan pertama Anda?',
                    style: AppTextStyles.h3.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  const AppTextField(
                    label: 'Jawaban',
                    hintText: 'Ketik jawaban Anda di sini...',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.l),

            // Info text
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(LucideIcons.info, size: 18, color: AppColors.warmMutedGray),
                const SizedBox(width: AppSpacing.s),
                Expanded(
                  child: Text(
                    'Jawaban tidak sensitif terhadap huruf besar/kecil. Pastikan ejaan Anda benar sesuai saat pertama kali mendaftar.',
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.warmMutedGray,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),

            AppButton(
              text: 'Verifikasi',
              icon: LucideIcons.badgeCheck,
              onPressed: () {
                context.push('/forgot-password/reset');
              },
            ),
            const SizedBox(height: AppSpacing.m),
            
            TextButton(
              onPressed: () {},
              child: Text(
                'Lupa jawaban? Hubungi dukungan',
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.olive700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
