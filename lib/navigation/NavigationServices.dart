import 'package:covid_tracker/navigation/navigation_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationService {
  void navigateTo(BuildContext context, String route, {NavigationData? extra});

  void navigateToNamed(BuildContext context, String route);

  void goBack(BuildContext context);
}

class NavigationServiceImpl extends NavigationService {
  @override
  void navigateTo(BuildContext context, String route, {NavigationData? extra}) {
    context.pushNamed(route, extra: extra);
  }

  @override
  void navigateToNamed(BuildContext context, String route) {
    context.goNamed(route);
  }

  @override
  void goBack(BuildContext context) {
    context.pop();
  }
}
