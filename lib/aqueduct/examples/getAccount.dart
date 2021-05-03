import 'package:mini_flow/aqueduct/aqueduct.dart';
import 'package:mini_flow/aqueduct/constants.dart';
import 'package:mini_flow/aqueduct/format.dart';

void main() async {
  final Aqueduct flow = Aqueduct(LOCALHOST, EMULATOR_PORT);
  final account = (await flow.getAccount(SERVICE_ACCOUNT)).account;

  final formatted = formatUFix64(account.balance);
  print("From Account: $formatted");

  final accountBalance = await flow.getAccountBalance(SERVICE_ACCOUNT);
  print("Direct: $accountBalance");

  print("✅ Done");
}
