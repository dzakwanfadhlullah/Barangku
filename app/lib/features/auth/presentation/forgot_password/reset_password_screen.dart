import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_spacing.dart';
import '../../../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';

class ResetPasswordScreen extends HookConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final isLoading = useState(false);

    final resetUsername = ref.read(resetUsernameProvider);

    return AppScaffold(
      showBackButton: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.l),

            // Hero Visual Area
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.warmMutedGray.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(
                  LucideIcons.lock, 
                  color: AppColors.olive700,
                  size: 36,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            
            Text(
              'Atur kata sandi baru',
              textAlign: TextAlign.center,
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: AppSpacing.s),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: Text(
                'Buat kata sandi baru untuk mengamankan akses lokal Anda.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLg.copyWith(
                  color: AppColors.warmMutedGray,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Form Fields
            AppTextField(
              controller: passwordController,
              label: 'Kata sandi baru',
              hintText: 'Minimal 8 karakter',
              isPassword: true,
            ),
            const SizedBox(height: AppSpacing.l),
            AppTextField(
              controller: confirmPasswordController,
              label: 'Konfirmasi kata sandi',
              hintText: 'Ulangi kata sandi',
              isPassword: true,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Security Requirements Chip
            Container(
              padding: const EdgeInsets.all(AppSpacing.m),
              decoration: BoxDecoration(
                color: AppColors.sage300.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LucideIcons.shieldCheck, color: AppColors.olive700, size: 20),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Keamanan Utama',
                          style: AppTextStyles.bodyMd.copyWith(
                            color: AppColors.olive700,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Gunakan kombinasi angka, simbol, dan huruf untuk keamanan maksimal inventaris Anda.',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.warmMutedGray,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),

            // Primary Action
            AppButton(
              text: isLoading.value ? 'Menyimpan...' : 'Simpan kata sandi',
              icon: isLoading.value ? null : const Icon(LucideIcons.arrowRight, size: 20),
              onPressed: isLoading.value
                  ? null
                  : () async {
                      if (resetUsername == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sesi telah berakhir, ulangi dari awal')),
                        );
                        context.go('/login');
                        return;
                      }

                      final pass = passwordController.text;
                      final conf = confirmPasswordController.text;

                      if (pass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Masukkan kata sandi baru!')),
                        );
                        return;
                      }

                      if (pass != conf) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Konfirmasi kata sandi tidak cocok!')),
                        );
                        return;
                      }

                      isLoading.value = true;
                      final repo = ref.read(authRepositoryProvider);
                      await repo.updatePassword(resetUsername, pass);

                      if (context.mounted) {
                        isLoading.value = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Kata sandi berhasil diubah. Silakan masuk.')),
                        );
                        // Clear reset state
                        ref.read(resetUsernameProvider.notifier).setUsername(null);
                        context.go('/login');
                      }
                    },
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Footer Help
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Membutuhkan bantuan?',
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.warmMutedGray),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: Text(
                    'Hubungi Dukungan',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.olive700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
