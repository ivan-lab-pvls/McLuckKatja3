import 'package:flutter/material.dart';
import 'package:mcluck_app/router/router.dart';

class McLuckApp extends StatelessWidget {
  McLuckApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'SF Pro Display'),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
