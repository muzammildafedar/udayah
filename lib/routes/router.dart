import 'package:go_router/go_router.dart';
import 'package:shippi/pages/dashboard_page.dart';
import 'package:shippi/pages/landing_page.dart';
import 'package:shippi/pages/login.dart';
import 'package:shippi/pages/not_found_page.dart';
import 'package:shippi/routes/auth_guard.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => Dashboard(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/404',
      builder: (context, state) => NotFoundScreen(),
    ),
  ],
  errorBuilder: (context, state) => NotFoundScreen(),
  redirect: (context, state) {
    final isAuthenticated = authGuard.isAuthenticated(context);
    final isLoggingIn = state.uri.toString() == '/login';
    final isOnPublicPage = state.uri.toString() == '/' || state.uri.toString() == '/404';

    // Redirect to login if not authenticated and trying to access a protected page
    if (!isAuthenticated && !isLoggingIn && !isOnPublicPage) {
      return '/login';
    }
    // If authenticated and trying to access the login page, redirect to dashboard
    if (isAuthenticated && isLoggingIn) {
      return '/dashboard';
    }

    return null;
  },
);
