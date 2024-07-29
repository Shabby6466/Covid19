import 'package:covid_tracker/screens/countries_list.dart';
import 'package:covid_tracker/screens/detail_screen.dart';
import 'package:covid_tracker/screens/worldstates.dart';
import 'package:covid_tracker/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GoRouter router =
        GoRouter(initialLocation: '/splash', routes: <RouteBase>[
      GoRoute(
          name: 'worldstate',
          path: '/worldstate',
          builder: (context, index) {
            return const WorldStates();
          }),
      GoRoute(
          name: 'splash',
          path: '/splash',
          builder: (context, index) {
            return const SplashScreen();
          }),
      GoRoute(
          name: 'countries',
          path: '/countries',
          builder: (context, index) {
            return const CountriesList();
          }),
      GoRoute(
          name: 'details',
          path: '/details',
          builder: (context, state) {
            final Map<String, String> params =
                state.extra as Map<String, String>;
            return DetailScreen(
              name: params['name']!,
              updated: params['updated']!,
              cases: params['cases']!,
              deaths: params['deaths']!,
              recovered: params['recovered']!,
              active: params['active']!,
              critical: params['critical']!,
              image: params['image']!,
            );
          })
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
