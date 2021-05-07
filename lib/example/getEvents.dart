import 'dart:convert';

import 'package:fixnum/fixnum.dart';

import 'package:mini_flow/fcl/constants.dart';
import 'package:mini_flow/fcl/fcl.dart';
import 'package:mini_flow/src/generated/flow/entities/event.pb.dart';


void main() async {
  final flow = FlowClient(LOCALHOST, EMULATOR_PORT);

  final blockHeigh = await flow.getBlockHeight();
  final events = await flow.getEventsInRange("flow.AccountCreated", rangeStart: Int64(0), rangeEnd: blockHeigh);

  // print(events);
  print(events.results.length);
  print(events.results.last);

  final payload = utf8.decode(events.results.last.events.last.payload);
  print(payload);

  print("✅ Done");
}

