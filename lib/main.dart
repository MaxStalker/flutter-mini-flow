import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:convert/convert.dart';

import 'package:flutter/material.dart';

import 'package:mini_flow/generated/flow/access/access.pb.dart';
import 'package:mini_flow/generated/flow/access/access.pbgrpc.dart';
import 'package:mini_flow/generated/flow/execution/execution.pbgrpc.dart';

import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart' as GRPC;
import 'package:grpc/grpc_connection_interface.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String res;
  ClientChannelBase channel;

/*  Future<void> _getBlockHeight() async {
    var hello = await HelloService.SayHello();
    setState(() {
      res = hello.response;
    });
  }*/

  Future<void> _ping() async {
    log('got channel');
    final stub = AccessAPIClient(channel, options: CallOptions(timeout: Duration(seconds: 2)));
    log('got stub');
    // final response = await stub.getLatestBlock(GetLatestBlockRequest());
    // final address = Uint8List.fromList("f8d6e0586b0a20c7".codeUnits);
    // final decoded =
    // final address = utf8.encode(0xf8d6e0586b0a20c7.toString()); //utf8.encode(hex.encode("0xf8d6e0586b0a20c7".codeUnits));

    final address = hex.decode("f8d6e0586b0a20c7");
    log(address.toString());
    final request = GetAccountAtLatestBlockRequest()..address = address;
    final response = await stub.getAccountAtLatestBlock(request);
    // log(response.toString());
    //log(utf8.decode());
    log(hex.encode(response.account.address));
  }

  @override
  void initState() {
    log("init");
    res = "Hello, Flow";

    channel = ClientChannel(
      '10.0.2.2',
      port: 3569,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    log("build");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              res
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ping,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
