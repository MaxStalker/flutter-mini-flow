import 'package:mini_flow/fcl/types.dart';

dynamic prepareArguments(List<CadenceValue> arguments){
  var args = List<CadenceValue>.empty();

  if (arguments != null){
    args = arguments;
  }
  final encodedArguments = args.map((e) => e.toMessage());

  return encodedArguments;
}