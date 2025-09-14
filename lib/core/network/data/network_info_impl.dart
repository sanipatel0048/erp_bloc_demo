import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ssvl_erp_system_bloc/core/network/domain/network_info.dart';

class NetworkInfoImpl extends NetworkInfo {
  final Connectivity connectivity;
  final _controller = StreamController<bool>.broadcast();

  NetworkInfoImpl(this.connectivity) {
    connectivity.onConnectivityChanged.listen((result) async {
      bool isOnline;

      isOnline = await isConnected();

      _controller.add(isOnline);
    });
  }

  @override
  Future<bool> isConnected() async {
    if (kIsWeb) {
      try {
        final response = await http.get(Uri.parse('https://www.google.com'));
        return response.statusCode == 200;
      } catch (_) {
        return false;
      }
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException {
        return false;
      }
    }
    }

  @override
  Stream<bool> get onConnectivityChanged => _controller.stream;
}
