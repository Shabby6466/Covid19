import 'package:covid_tracker/utils/injection.dart';
import 'package:covid_tracker/navigation/NavigationRoutes.dart';
import 'package:covid_tracker/utils/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  setup();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Navigationroutes _routes = Navigationroutes();

    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp.router(
            routerConfig: _routes.goRoute,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.light(), // Light theme
            darkTheme: ThemeData.dark(), // Dark theme
            themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          ),
        );
      },
    );
  }
}
