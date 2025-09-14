abstract class ConnectivityEvent {}

class StartMonitoring extends ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final bool isConnected;
  ConnectivityChanged(this.isConnected);
}