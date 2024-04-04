import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@singleton
class InternetConnectionService {
  final connectivityResultController = StreamController<ConnectivityResult>();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  void init() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
          connectivityResultController.add,
        );
  }

  Stream<ConnectivityResult> get connectivityResultStream =>
      connectivityResultController.stream;

  void dispose() {
    _connectivitySubscription?.cancel();
    connectivityResultController.close();
  }
}
