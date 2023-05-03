import 'package:agconnect_auth/agconnect_auth.dart';
import 'package:crypto_quest/other/route_app.dart';
import 'package:crypto_quest/service/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  
  appSettings();
  //TODO: dialog service 
  runApp(ProviderScope(child: const MyApp()));
}

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DialogService());
}


appSettings(){
  /// DI
  setupLocator();
  /// Hive Database
  
  /// Init push service
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.routerSettigs,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     
    );
  }
}



