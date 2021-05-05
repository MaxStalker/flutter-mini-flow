import 'package:mini_flow/fcl/fcl.dart';

void main() async {
  final endpoint = "localhost";
  final port = FlowClient.FLOW_EMULATOR_PORT;
  final FlowClient flow = FlowClient( endpoint, port);

  final code = '''
    pub fun main(): Int {
      log("Hello from FlowClient");
      return 42
    }
  ''';

  final result = await flow.executeScript(code);
  print(result);
  final decoded = await flow.decodeResponse(result);
  print(decoded);

  print("✅ Done");
}