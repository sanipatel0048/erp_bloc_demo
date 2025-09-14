abstract class NetworkInfo {
  Future<bool> isConnected();

  Stream<bool> get onConnectivityChanged;
}
