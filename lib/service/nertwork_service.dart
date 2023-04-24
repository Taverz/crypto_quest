
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum ConnectivityStatus { NotDetermined, isConnected, isDisonnected }

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {

   ConnectivityStatus? lastResult;
  ConnectivityStatus? newState;

  ConnectivityStatusNotifier() : super(ConnectivityStatus.isConnected) {
    if (state == ConnectivityStatus.isConnected) {
      lastResult = ConnectivityStatus.isConnected;
    } else {
      lastResult = ConnectivityStatus.isDisonnected;
    }
    lastResult = ConnectivityStatus.NotDetermined;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          newState = ConnectivityStatus.isConnected;
          break;
        case ConnectivityResult.none:
          newState = ConnectivityStatus.isDisonnected;
          break;
        case ConnectivityResult.bluetooth:
          // TODO: Handle this case.
          break;
        case ConnectivityResult.ethernet:
          // TODO: Handle this case.
          break;
        case ConnectivityResult.vpn:
          // TODO: Handle this case.
          break;
        case ConnectivityResult.other:
          // TODO: Handle this case.
          break;
      }
      if (newState != lastResult) {
        state = newState!;
        lastResult = newState;
      }
    });
  }
}

// Final Global Variable which will expose the state.
// Should be outside of the class. 

final StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus?>  connectivityStatusProviders = StateNotifierProvider((ref) {
  return ConnectivityStatusNotifier();
});

listenerConnectSnackbar(BuildContext context, WidgetRef ref ){
  ConnectivityStatus? connectivityStatusProvider = ref.watch(connectivityStatusProviders);
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          connectivityStatusProvider == ConnectivityStatus.isConnected
              ? 'Is Connected to Internet'
              : 'Is Disconnected from Internet',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: connectivityStatusProvider ==
                ConnectivityStatus.isConnected
            ? Colors.green
            : Colors.red,
      ),
    );
  });
}
