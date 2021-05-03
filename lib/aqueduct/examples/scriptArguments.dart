import 'dart:convert';
import 'dart:ffi';
import 'package:fixnum/fixnum.dart';

import 'package:mini_flow/aqueduct/aqueduct.dart';
import 'package:mini_flow/aqueduct/constants.dart';
import 'package:mini_flow/generated/flow/access/access.pb.dart';

void main() async {
  final flowWay = Aqueduct(LOCALHOST, EMULATOR_PORT);

  final code = '''
    pub fun main(number: Int){
      log("this is working")
      log(number)
    }
  ''';

  const rawArguments = [];

  final scriptRequest = ExecuteScriptAtBlockHeightRequest()
    ..blockHeight = Int64(0)
    ..script = utf8.encode(code)
    ..arguments = List();

  final response = await flowWay.getAccessClient().executeScriptAtBlockHeight(scriptRequest);
  print(response);

  print("✅ Done");
}