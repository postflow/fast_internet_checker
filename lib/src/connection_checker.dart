// library fast_internet_checker;

import 'dart:async';
import 'dart:io';

import 'connection_switcher.dart';

class ConnectionChecker {
  final Duration interval;
  final Function(ConnectionStatus result)? connectionCallback;
  final Stream _periodicStream;

  ConnectionChecker({this.interval = const Duration(seconds: 10), this.connectionCallback}) : _periodicStream = Stream.periodic(interval, (int count) async {
    try {
      await Socket.connect('8.8.8.8', 53);
    } catch (e) {
      return Future.value(ConnectionStatus.connectionFailure);
    }
    return Future.value(ConnectionStatus.connectionOk);
  }).asBroadcastStream();

  ConnectionSwitcher init() => ConnectionSwitcher(_periodicStream, connectionCallback);
}


