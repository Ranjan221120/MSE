import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  final Connectivity _connectivity = Connectivity();

  factory ConnectivityService() {
    return _instance;
  }

  ConnectivityService._internal() {
    _startListening();
  }

  late Stream<List<ConnectivityResult>> _connectivityStream;
  
  void _startListening() {
    _connectivityStream = _connectivity.onConnectivityChanged;
  }

  Stream<bool> getConnectionStream() {
    return _connectivityStream.map((result) => 
      !result.contains(ConnectivityResult.none)
    ).distinct();
  }


  Future<bool> hasInternetConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return !result.contains(ConnectivityResult.none);
    } catch (e) {
      debugPrint('Connectivity check error: $e');
      return false;
    }
  }

  Stream<String> getConnectionStatusStream() {
    return _connectivityStream.map((result) {
      if (result.contains(ConnectivityResult.wifi)) {
        return 'WiFi';
      } else if (result.contains(ConnectivityResult.mobile)) {
        return 'Mobile Data';
      } else {
        return 'No Internet';
      }
    }).distinct();
  }
  
  Future<List<ConnectivityResult>> getConnectionStatus() async {
    try {
      return await _connectivity.checkConnectivity();
    } catch (e) {
      debugPrint('Get connection status error: $e');
      return [ConnectivityResult.none];
    }
  }

  Future<String> getConnectionStatusString() async {
    final statusList = await getConnectionStatus();
    if (statusList.contains(ConnectivityResult.wifi)) {
      return 'WiFi';
    } else if (statusList.contains(ConnectivityResult.mobile)) {
      return 'Mobile Data';
    } else {
      return 'No Internet';
    }
  }
}
