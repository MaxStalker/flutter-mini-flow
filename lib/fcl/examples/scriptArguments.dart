import 'dart:convert';
import 'dart:ffi';
import 'package:fixnum/fixnum.dart';

import 'package:mini_flow/fcl/fcl.dart';
import 'package:mini_flow/fcl/constants.dart';
import 'package:mini_flow/fcl/types.dart';
import 'package:mini_flow/generated/flow/access/access.pb.dart';

void main() async {
  final flow = FlowClient(LOCALHOST, EMULATOR_PORT);

  final code = '''
    pub fun main(message: String): Int {
      log(message)
      return 42
    }
  ''';

  final args = [
    CadenceValue(value: "Hello from Dart Flow Client", type: CadenceType.String)
  ];

  final response = await flow.executeScript(code, args);
  final Map<String, dynamic> decodedResult = flow.decodeResponse(response);
  final cadenceValue = CadenceValue.fromJson(decodedResult);

  print("✅ Done");
}
