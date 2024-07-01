import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_store/core/domain/di/di.dart';
import 'package:new_store/core/domain/router/router.dart';
import 'package:new_store/theme/themes/themeData.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Di.init();
  final dio = Dio();
  dio.options.headers['Demo-Header'] = 'demo header';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: themeData,
       routerConfig: router,
    );
  }
}

