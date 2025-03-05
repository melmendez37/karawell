import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController{
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResult){
    if(connectivityResult.contains(ConnectivityResult.none)){
      Get.rawSnackbar(
        messageText: const Text(
          'Please connect to a network',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.red.shade400,
        icon: const Icon(Icons.signal_wifi_bad, color: Colors.white, size: 35,),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED
      );
    } else {
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }
}