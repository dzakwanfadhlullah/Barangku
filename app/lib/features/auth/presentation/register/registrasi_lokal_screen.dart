import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card_section.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';

class RegistrasiLokalScreen extends HookConsumerWidget {
  const RegistrasiLokalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final namaUsahaController = useTextEditingController();
    final pemilikController = useTextEditingController();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final answerController = useTextEditingController();
    final selectedQuestion = useState<String?>('q1');
    final isLoading = useState(false);

    final questions = {
      'q1': 'Apa nama hewan peliharaan pertama Anda?',
      'q2': 'Di kota mana ibu Anda lahir?',
      'q3': 'Apa nama sekolah dasar pertama Anda?',
    };

    return AppScaffold(
      title: 'Registrasi Lokal',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Information Card
            Container(
              padding: const EdgeInsets.all(AppSpacing.m),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.info.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.hardDrive, color: AppColors.info, size: 24),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: Text(
                      'Semua data akan disimpan secara lokal di perangkat ini demi privasi dan kecepatan.',
                      style: AppTextStyles.bodySm.copyWith(color: AppColors.softCharcoal),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppSpacing.xl),

            // Identitas Usaha
            AppCardSection(
              title: 'Identitas Usaha',
              child: Column(
                children: [
                  AppTextField(
                    controller: namaUsahaController,
                    label: 'Nama usaha',
                    hintText: 'Contoh: Toko Makmur',
                  ),
                  const SizedBox(height: AppSpacing.l),
                  AppTextField(
                    controller: pemilikController,
                    label: 'Nama pemilik',
                    hintText: 'Contoh: Budi Santoso',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Data Masuk
            AppCardSection(
              title: 'Data Masuk',
              child: Column(
                children: [
                  AppTextField(
                    controller: usernameController,
                    label: 'Username',
                    hintText: 'Untuk masuk ke aplikasi',
                    helperText: 'Gunakan huruf kecil tanpa spasi',
                  ),
                  const SizedBox(height: AppSpacing.l),
                  AppTextField(
                    controller: passwordController,
                    label: 'Kata sandi',
                    isPassword: true,
                  ),
                  const SizedBox(height: AppSpacing.l),
                  AppTextField(
                    controller: confirmPasswordController,
                    label: 'Konfirmasi kata sandi',
                    isPassword: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Pemulihan Akun
            AppCardSection(
              title: 'Pemulihan Akun',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Pilih pertanyaan keamanan',
                    style: AppTextStyles.labelMd.copyWith(color: AppColors.softCharcoal),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedQuestion.value,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.neutralDivider),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.olive500, width: 2),
                      ),
                    ),
                    items: questions.entries.map((e) {
                      return DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedQuestion.value = value;
                    },
                    hint: const Text('Pilih pertanyaan'),
                    style: AppTextStyles.bodyLg,
                    icon: const Icon(LucideIcons.chevronDown, color: AppColors.warmMutedGray),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  AppTextField(
                    controller: answerController,
                    label: 'Jawaban',
                    hintText: 'Jawaban Anda',
                    helperText: 'Penting untuk mereset kata sandi jika lupa',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Main CTA
            AppButton(
              text: isLoading.value ? 'Memproses...' : 'Buat Akun Lokal',
              onPressed: isLoading.value
                  ? null
                  : () async {
                      final name = pemilikController.text.trim();
                      final username = usernameController.text.trim().toLowerCase();
                      final password = passwordController.text;
                      final confirm = confirmPasswordController.text;
                      final answer = answerController.text.trim();

                      if (name.isEmpty || username.isEmpty || password.isEmpty || answer.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tolong lengkapi semua data!')),
                        );
                        return;
                      }

                      if (password != confirm) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Kata sandi tidak cocok!')),
                        );
                        return;
                      }

                      isLoading.value = true;
                      
                      final questionText = questions[selectedQuestion.value] ?? '';
                      final success = await ref.read(authStateProvider.notifier).register(
                            name: name,
                            username: username,
                            password: password,
                            question: questionText,
                            answer: answer,
                          );

                      if (context.mounted) {
                        isLoading.value = false;
                        if (success) {
                          context.push('/register/success');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Username sudah terdaftar atau terjadi kesalahan!')),
                          );
                        }
                      }
                    },
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
