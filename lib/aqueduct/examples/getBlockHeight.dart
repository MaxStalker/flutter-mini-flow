import 'package:mini_flow/aqueduct/aqueduct.dart';

void main() async {
  final port = Aqueduct.FLOW_EMULATOR_PORT;
  final flow = Aqueduct("localhost", port);

  final height = await flow.getBlockHeight();
  print(height);

  print("✅ Done");
}