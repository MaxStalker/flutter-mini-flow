import 'package:mini_flow/fcl/fcl.dart';

void main() async {
  final port = FlowClient.FLOW_EMULATOR_PORT;
  final flow = FlowClient("localhost", port);

  final height = await flow.getBlockHeight();
  print(height);

  print("✅ Done");
}