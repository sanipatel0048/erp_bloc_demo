import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/network_info.dart';
import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final NetworkInfo networkInfo;

  ConnectivityBloc(this.networkInfo) : super(ConnectivityInitial()) {
    on<StartMonitoring>((event, emit) async {
      final initial = await networkInfo.isConnected();
      emit(initial ? ConnectivityOnline() : ConnectivityOffline());
      await emit.forEach(
        networkInfo.onConnectivityChanged,
        onData: (isConnected) {
          return isConnected ? ConnectivityOnline() : ConnectivityOffline();
        },
      );
    });
  }
}
