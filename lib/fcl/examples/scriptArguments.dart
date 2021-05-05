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
    pub fun main(message: String): String {
      log("this is working")
      log(message)
      
      return "I believe I can fly"
    }
  ''';

  final rawArguments = [
    CadenceString("Hello from FlowClient").toMessage()
  ];

  final scriptRequest = ExecuteScriptAtBlockHeightRequest()
    ..blockHeight = Int64(0)
    ..script = utf8.encode(code);

  scriptRequest.arguments.insertAll(0, rawArguments);

  final response = await flow.getAccessClient().executeScriptAtBlockHeight(scriptRequest);
  print(response);

  final decoded = utf8.decode(response.value);
  final Map<String, dynamic> scriptResult = jsonDecode(decoded);
  print("Result type: ${scriptResult['type']}");
  print("Result value: ${scriptResult['value']}");

  print("✅ Done");
}