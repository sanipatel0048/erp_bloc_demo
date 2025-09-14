import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'core/di/service_locator.dart';
import 'core/network/data/network_info_impl.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final networkInfo = NetworkInfoImpl(Connectivity());
  //Initialize service locator
  await init();
  //Remove # sign from URL
  usePathUrlStrategy();
  runApp(MyApp(networkInfo: networkInfo));
}
