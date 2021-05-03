import 'package:mini_flow/aqueduct/aqueduct.dart';

void main() async {
  final endpoint = "localhost";
  final port = Aqueduct.FLOW_EMULATOR_PORT;
  final Aqueduct flow = Aqueduct(endpoint, port);

  final latestBlock = await flow.getBlock();
  print(latestBlock);

  print("✅ Done");
}