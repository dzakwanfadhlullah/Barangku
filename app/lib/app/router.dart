import 'package:go_router/go_router.dart';
import '../features/auth/presentation/login/login_screen.dart';
import '../features/auth/presentation/register/registrasi_lokal_screen.dart';
import '../features/auth/presentation/register/registration_success_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/splash/presentation/splash_screen.dart';

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
      path: '/register',
      builder: (context, state) => const RegistrasiLokalScreen(),
      routes: [
        GoRoute(
          path: 'success',
          builder: (context, state) => const RegistrationSuccessScreen(),
        ),
      ]
    ),
  ],
);
