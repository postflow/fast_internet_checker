
# A simple package on pure Dart to check connection to internet. Also provide a method to listen for connection status changes.

## Features

Check connection to internet

## Getting started

Override initState method for initialize library and pass connection callback:
```
import 'package:fast_internet_checker/fast_internet_checker.dart';

late ConnectionSwitcher connectionSwitcher;

connectionStatusHandler(ConnectionStatus result) {
    print('result = $result');
}
 
 @override
  void initState() {
    super.initState();
    connectionSwitcher =  ConnectionChecker(
        interval: const Duration(seconds: 1),
        connectionCallback: connectionStatusHandler)
    .init();
  }
```

## Usage

ConnectionSwitcher - its component that need start and stop checking connection.

start listening connection status:
 ```
 connectionSwitcher.start();
 ```
or stop listening:
 ```
 connectionSwitcher.stop();
 ```

## Additional information
Full working example:
```Dart
import 'package:fast_internet_checker/fast_internet_checker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test connect app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ConnectionSwitcher connectionSwitcher;

  connectionStatusHandler(ConnectionStatus result){
    print('result = $result');
  }

  @override
  void initState() {
    super.initState();
    connectionSwitcher =  ConnectionChecker(interval: const Duration(seconds: 1), connectionCallback: connectionStatusHandler).init();
  }

  void _startInetCheck() {
    connectionSwitcher.start();
  }

  void _stopInetCheck() {
    connectionSwitcher.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Test connect app',
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
      floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _startInetCheck,
            tooltip: 'start',
            child: const Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: _stopInetCheck,
            tooltip: 'stop',
            child: const Icon(Icons.stop),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

```

