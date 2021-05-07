
import 'dart:convert';

import 'package:mini_flow/fcl/constants.dart';
import 'package:mini_flow/fcl/fcl.dart';

void main() async{
  final flow = FlowClient(LOCALHOST, EMULATOR_PORT);

  final code = '''
    transaction{
      prepare(){
        log("hello")
      }
    }
  ''';

  final response = await flow.sendTransaction(code);
  print(response);

  print("✅ Done");
}