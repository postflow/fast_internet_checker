import 'dart:async';

enum ConnectionStatus {
  connectionOk,
  connectionFailure
}

class ConnectionSwitcher {
  final Stream _stream;
  StreamSubscription? _subscription;
  Function(ConnectionStatus connectionStatust)? resultCallback;

  ConnectionSwitcher(this._stream, this.resultCallback);

  stop() => _subscription?.pause();

  start() {
    final isPaused = _subscription?.isPaused ?? false;

    if (!isPaused) {
      _subscription = _stream.listen((futureResult) async {
        final ConnectionStatus result = await futureResult;
        resultCallback?.call(result);
      });
      return;
    }
    _subscription?.resume();
  }

}