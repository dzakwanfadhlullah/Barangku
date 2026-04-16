import 'package:go_router/go_router.dart';
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

final appRouter = GoRouter(
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
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
      routes: [
        GoRoute(
          path: 'settings',
          builder: (context, state) => const AccountSettingsScreen(),
        ),
      ]
    ),
  ],
);
