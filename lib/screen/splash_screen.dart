

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final providerSplashScreen = Provider((ref) => SplashScreenProvider());

class SplashScreenProvider {

  Future<void> startDelayed() async {
    await Future.delayed(const Duration(seconds: 2));
  }
  Future<void> loaded(Function(bool) endDalayedSuccess) async {
    await startDelayed();
    endDalayedSuccess(true);
  }
}



class SplashScreen extends HookConsumerWidget  {

  static const TTILE_SPLASHSCREEN = 'SplashScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SplashScreenProvider  watchVal = ref.watch(providerSplashScreen);
    watchVal.loaded((successLoad){
      if(successLoad)
      context.go('/login_page');
    });
    return Scaffold(
      body: SafeArea(child: Container(child: const Center(child: Text(TTILE_SPLASHSCREEN),),),),
    );
  }
}