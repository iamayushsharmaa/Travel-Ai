import 'package:go_router/go_router.dart';

import '../../features/addtrip/screens/add_trip_page.dart';
import '../../features/auth/screens/onboarding_page.dart';
import '../../features/auth/screens/signin_page.dart';
import '../../features/auth/screens/signup_page.dart';
import '../../features/history/screen/trip_history.dart';
import '../../features/search/screens/search_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/trip/screen/home_page.dart';
import '../../features/trip/screen/trip_detail_page.dart';
import '../navigation/app_scaffold.dart';
import 'app_routes.dart';

class RouteBuilders {
  static List<RouteBase> buildRoutes() {
    return [
      GoRoute(
        path: AppRoutes.onboarding,
        name: RouteNames.onboarding,
        builder: (_, __) => const OnBoardingPage(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        name: RouteNames.signIn,
        builder: (_, __) => SigninPage(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: RouteNames.signUp,
        builder: (_, __) => SignUpPage(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.home,
            name: RouteNames.home,
            builder: (_, __) => const HomePage(),
          ),
          GoRoute(
            path: AppRoutes.history,
            name: RouteNames.history,
            builder: (_, __) => const TripHistory(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: RouteNames.settings,
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),

      GoRoute(
        path: AppRoutes.planTrip,
        name: RouteNames.planTrip,
        builder: (_, __) => const AddTripPage(),
      ),
      GoRoute(
        path: AppRoutes.tripDetail,
        name: RouteNames.trip,
        builder: (_, state) {
          final travelId = state.pathParameters['travelId']!;
          return TripDetailPage(travelId: travelId);
        },
      ),
      GoRoute(
        path: AppRoutes.search,
        name: RouteNames.search,
        builder: (_, __) => const SearchScreen(),
      ),
    ];
  }
}
