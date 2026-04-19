import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/app_shell_screen.dart';

import '../features/auth/presentation/login/login_screen.dart';
import '../features/auth/presentation/register/registrasi_lokal_screen.dart';
import '../features/auth/presentation/register/registration_success_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/auth/presentation/forgot_password/forgot_password_screen.dart';
import '../features/auth/presentation/forgot_password/verification_screen.dart';
import '../features/auth/presentation/forgot_password/reset_password_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/profile/presentation/account_settings_screen.dart';

// New Batch 3 Screens
import '../features/dashboard/presentation/beranda_screen.dart';
import '../features/inventory/presentation/daftar_barang_screen.dart';
import '../features/inventory/presentation/detail_barang_screen.dart';
import '../features/inventory/presentation/tambah_barang_screen.dart';
import '../features/inventory/presentation/ubah_barang_screen.dart';
import '../features/inventory/data/models/item_model.dart';

// Placeholder for missing feature
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Aktivitas under construction")),
    );
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorBerandaKey = GlobalKey<NavigatorState>(debugLabel: 'shellBeranda');
final _shellNavigatorBarangKey = GlobalKey<NavigatorState>(debugLabel: 'shellBarang');
final _shellNavigatorAktivitasKey = GlobalKey<NavigatorState>(debugLabel: 'shellAktivitas');
final _shellNavigatorProfilKey = GlobalKey<NavigatorState>(debugLabel: 'shellProfil');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
      routes: [
        GoRoute(
          path: 'verify',
          builder: (context, state) => const VerificationScreen(),
        ),
        GoRoute(
          path: 'reset',
          builder: (context, state) => const ResetPasswordScreen(),
        ),
      ]
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegistrasiLokalScreen(),
      routes: [
        GoRoute(
          path: 'success',
          builder: (context, state) => const RegistrationSuccessScreen(),
        ),
      ]
    ),

    // Shell Route handles the Bottom Navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShellScreen(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0: Beranda
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBerandaKey,
          routes: [
            GoRoute(
              path: '/beranda',
              builder: (context, state) => const BerandaScreen(),
            ),
          ],
        ),
        // Tab 1: Barang (Koleksi)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBarangKey,
          routes: [
            GoRoute(
              path: '/barang',
              builder: (context, state) => const DaftarBarangScreen(),
              routes: [
                GoRoute(
                  path: 'detail',
                  builder: (context, state) => DetailBarangScreen(item: state.extra as ItemModel),
                ),
                GoRoute(
                  path: 'tambah',
                  builder: (context, state) => const TambahBarangScreen(),
                ),
                GoRoute(
                  path: 'ubah',
                  builder: (context, state) => UbahBarangScreen(item: state.extra as ItemModel),
                ),
              ],
            ),
          ],
        ),
        // Tab 2: Aktivitas
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAktivitasKey,
          routes: [
            GoRoute(
              path: '/aktivitas',
              builder: (context, state) => const PlaceholderScreen(),
            ),
          ],
        ),
        // Tab 3: Profil
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfilKey,
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(
                  path: 'settings',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const AccountSettingsScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
