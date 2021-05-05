import 'package:mini_flow/fcl/fcl.dart';
import 'package:mini_flow/fcl/constants.dart';
import 'package:mini_flow/fcl/format.dart';

void main() async {
  final FlowClient flow = FlowClient(LOCALHOST, EMULATOR_PORT);
  final account = (await flow.getAccount(SERVICE_ACCOUNT)).account;

  final formatted = formatUFix64(account.balance);
  print("From Account: $formatted");

  final accountBalance = await flow.getAccountBalance(SERVICE_ACCOUNT);
  print("Direct: $accountBalance");

  print("✅ Done");
}
