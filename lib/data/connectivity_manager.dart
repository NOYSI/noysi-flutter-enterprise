import 'dart:async';
import 'dart:io';

import 'package:code/_di/injector.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

import '../enums.dart';

BehaviorSubject<ConnectivityAppStatus> onConnectivityChangeController =
    BehaviorSubject();

BehaviorSubject<bool> hasInternetController = BehaviorSubject();

class ConnectivityManager {
  Connectivity? _connectivity;

  ConnectivityManager() {
    if (_connectivity == null)
      _connectivity = Connectivity();
  }

  Future<ConnectivityAppStatus> checkConnectivity() async {
    var connectivityResult = await _connectivity?.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return ConnectivityAppStatus.mobile;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return ConnectivityAppStatus.wifi;
    } else {
      return ConnectivityAppStatus.none;
    }
  }

  ConnectivityManager.initConnectivityAndInternetCheckerWithListeners() {
    if (_connectivity == null) _connectivity = Connectivity();
    final host = Injector.instance.baseUrl.replaceFirst("https://", "");
    _connectivity?.onConnectivityChanged.listen((ConnectivityResult? status) {
      if (status != null)
        onConnectivityChangeController
            .sinkAddSafe(status == ConnectivityResult.mobile
            ? ConnectivityAppStatus.mobile
            : status == ConnectivityResult.wifi
            ? ConnectivityAppStatus.wifi
            : ConnectivityAppStatus.none);
    });

    onConnectivityChangeController.listen((ConnectivityAppStatus? value) async {
      if (value != null) {
        var hasInternet = false;
        if (value != ConnectivityAppStatus.none) {
          hasInternet = await _checkConnectionToHost(host);
        }
        hasInternetController.sinkAddSafe(hasInternet);
      }
    });

    Timer.periodic(Duration(seconds: 5), (timer) async {
      final hasInternet = await _checkConnectionToHost(host);
      hasInternetController.sinkAddSafe(hasInternet);
    });
  }

  Future<bool> _checkConnectionToHost(String host) async {
    try {
      final result = await InternetAddress.lookup(host);
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch(ex) {
      print("SocketException Connection Check Routine: ${ex.toString()}");
      return false;
    }
  }
}
