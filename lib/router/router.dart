import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:mcluck_app/screens/home/home_screen.dart';
import 'package:mcluck_app/screens/onboarding/onboarding_screen.dart';
import 'package:mcluck_app/screens/prediction/add_prediction/add_prediction_screen.dart';
import 'package:mcluck_app/screens/prediction/prediction_list/prediction_list_screen.dart';
import 'package:mcluck_app/screens/settings/settings_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: PredictionListRoute.page),
        AutoRoute(page: AddPredictionRoute.page),
    AutoRoute(page: SettingsRoute.page),

  ];
}
