import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card_section.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';

class RegistrasiLokalScreen extends StatelessWidget {
  const RegistrasiLokalScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.info.withOpacity(0.2)),
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
            const AppCardSection(
              title: 'Identitas Usaha',
              child: Column(
                children: [
                  AppTextField(
                    label: 'Nama usaha',
                    hintText: 'Contoh: Toko Makmur',
                  ),
                  SizedBox(height: AppSpacing.l),
                  AppTextField(
                    label: 'Nama pemilik',
                    hintText: 'Contoh: Budi Santoso',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Data Masuk
            const AppCardSection(
              title: 'Data Masuk',
              child: Column(
                children: [
                  AppTextField(
                    label: 'Username',
                    hintText: 'Untuk masuk ke aplikasi',
                    helperText: 'Gunakan huruf kecil tanpa spasi',
                  ),
                  SizedBox(height: AppSpacing.l),
                  AppTextField(
                    label: 'Kata sandi',
                    isPassword: true,
                  ),
                  SizedBox(height: AppSpacing.l),
                  AppTextField(
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
                    items: const [
                      DropdownMenuItem(
                        value: 'q1',
                        child: Text('Apa nama hewan peliharaan pertama Anda?'),
                      ),
                      DropdownMenuItem(
                        value: 'q2',
                        child: Text('Di kota mana ibu Anda lahir?'),
                      ),
                    ],
                    onChanged: (value) {},
                    hint: const Text('Pilih pertanyaan'),
                    style: AppTextStyles.bodyLg,
                    icon: const Icon(LucideIcons.chevronDown, color: AppColors.warmMutedGray),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  const AppTextField(
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
              text: 'Buat Akun Lokal',
              onPressed: () {
                context.push('/register/success');
              },
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
