import 'package:mini_flow/aqueduct/aqueduct.dart';

void main() async {
  final endpoint = "localhost";
  final port = Aqueduct.FLOW_EMULATOR_PORT;
  final Aqueduct flow = Aqueduct( endpoint, port);

  final code = '''
    pub fun main(): Int {
      log("Hello from Aqueduct");
      return 42
    }
  ''';

  final result = await flow.executeScript(code);
  print(result);
  final decoded = await flow.decodeResponse(result);
  print(decoded);

  print("✅ Done");
}