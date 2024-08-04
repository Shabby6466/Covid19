import 'package:covid_tracker/navigation/navigation_data.dart';
import 'package:covid_tracker/screens/countries_list.dart';
import 'package:covid_tracker/screens/detail_screen.dart';
import 'package:covid_tracker/screens/worldstates.dart';
import 'package:covid_tracker/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

class Navigationroutes {
  static const countriesList = '/countrieslist';
  static const detailScreen = '/detailscreen';
  static const worldStates = '/worldStates';
  static const splashScreen = '/';

  GoRouter goRoute = GoRouter(routes: <RouteBase>[
    GoRoute(
      name: Navigationroutes.splashScreen,
      path: Navigationroutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: Navigationroutes.countriesList,
      path: Navigationroutes.countriesList,
      builder: (context, state) => const CountriesList(),
    ),
    GoRoute(
      name: Navigationroutes.worldStates,
      path: Navigationroutes.worldStates,
      builder: (context, state) => const WorldStates(),
    ),
    GoRoute(
        name: Navigationroutes.detailScreen,
        path: Navigationroutes.detailScreen,
        builder: (context, state) => DetailScreen(data: state.extra as NavigationData,),
    ),
  ]);
}
