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

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final isLoading = useState(false);

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
                  LucideIcons.listRestart,
                  color: AppColors.olive700,
                  size: 36,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Lupa kata sandi',
              textAlign: TextAlign.center,
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: AppSpacing.s),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: Text(
                'Masukkan username Anda untuk memulihkan akun lokal di perangkat ini.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLg.copyWith(
                  color: AppColors.olive700,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Form Section
            AppTextField(
              controller: usernameController,
              label: 'Username',
              hintText: 'Contoh: budi_arsip',
            ),
            const SizedBox(height: AppSpacing.l),
            AppButton(
              text: isLoading.value ? 'Memeriksa...' : 'Lanjutkan',
              icon: isLoading.value ? null : const Icon(LucideIcons.chevronRight, size: 20),
              onPressed: isLoading.value
                  ? null
                  : () async {
                      final username = usernameController.text.trim();
                      if (username.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tolong masukkan username Anda!')),
                        );
                        return;
                      }

                      isLoading.value = true;
                      final repo = ref.read(authRepositoryProvider);
                      final user = await repo.getUserByUsername(username);

                      if (context.mounted) {
                        isLoading.value = false;
                        if (user != null) {
                          // Save target username
                          ref.read(resetUsernameProvider.notifier).setUsername(user.username);
                          context.push('/forgot-password/verify');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Username tidak ditemukan di perangkat ini!')),
                          );
                        }
                      }
                    },
            ),
            
            const SizedBox(height: AppSpacing.xxxl),

            // Trust & Safety Note
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.sage300.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.neutralDivider.withValues(alpha: 0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(LucideIcons.shield, size: 16, color: AppColors.olive700),
                    const SizedBox(width: AppSpacing.s),
                    Text(
                      'Data akun Anda tersimpan aman di perangkat ini.',
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.olive700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Help Links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Butuh bantuan?',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.olive700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: 4,
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    color: AppColors.neutralDivider,
                    shape: BoxShape.circle,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Kontak Support',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.olive700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
