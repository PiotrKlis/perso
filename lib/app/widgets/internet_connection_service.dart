import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

//TODO: Shouldn't be accessed directly but by bloc
@singleton
class InternetConnectionService {
  final connectivityResultController = StreamController<ConnectivityResult>();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  void init() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((event) {
      connectivityResultController.add(event.first);
    });
  }

  Stream<ConnectivityResult> get connectivityResultStream =>
      connectivityResultController.stream;

  void dispose() {
    _connectivitySubscription?.cancel();
    connectivityResultController.close();
  }
}
