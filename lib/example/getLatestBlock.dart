import 'package:mini_flow/fcl/constants.dart';
import 'package:mini_flow/fcl/fcl.dart';

void main() async {
  final FlowClient flow = FlowClient(LOCALHOST, EMULATOR_PORT);

  final latestBlock = await flow.getBlock();
  print(latestBlock);

  print("✅ Done");
}