import 'package:mini_flow/fcl/fcl.dart';

void main() async {
  final endpoint = "localhost";
  final port = FlowClient.FLOW_EMULATOR_PORT;
  final FlowClient flow = FlowClient(endpoint, port);

  final latestBlock = await flow.getBlock();
  print(latestBlock);

  print("✅ Done");
}