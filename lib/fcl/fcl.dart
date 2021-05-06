import 'dart:convert';
import 'dart:ffi';
import 'package:convert/convert.dart';

import 'package:fixnum/fixnum.dart';

import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

// Local utilities
import 'package:mini_flow/fcl/format.dart';
import 'package:mini_flow/fcl/types.dart';

// Flow protobuf
import 'package:mini_flow/generated/flow/access/access.pb.dart';
import 'package:mini_flow/generated/flow/access/access.pbgrpc.dart';
import 'package:mini_flow/generated/flow/execution/execution.pbgrpc.dart';

class FlowClient {
  String endPoint;
  int port;
  ClientChannelBase channel;

  AccessAPIClient accessClient;
  ExecutionAPIClient executionClient;

  static const String MOBILE_EMULATOR_ENDPOINT = '10.0.2.2';
  static const int FLOW_EMULATOR_PORT = 3569;

  FlowClient(this.endPoint, this.port) {
    this
      ..channel = ClientChannel(
        this.endPoint,
        port: this.port,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
  }

  AccessAPIClient getAccessClient() {
    if (accessClient == null) {
      this.accessClient = AccessAPIClient(this.channel,
          options: CallOptions(timeout: Duration(seconds: 2)));
    }
    return this.accessClient;
  }

  Future<AccountResponse> getAccount(String address, {Int64 height}) async {
    /* TODO: Implement at later stage
    var blockHeight = height;
    if (height == null) {
      blockHeight = await this.getBlockHeight();
    }


    final request = GetAccountAtBlockHeightRequest()
      ..blockHeight = blockHeight
      ..address = hex.decode(address);

     */
    final request = GetAccountAtLatestBlockRequest()
      ..address = hex.decode(address);
    return this.getAccessClient().getAccountAtLatestBlock(request);
  }

  /// Gets account FLOW balance as string.
  Future<String> getAccountBalance(String address) async {
    final account = (await this.getAccount(address)).account;
    return formatUFix64(account.balance);
  }

  /// Gets block at specified [height] or latest available.
  Future<BlockResponse> getBlock({Int64 height}) {
    final client = this.getAccessClient();
    if (height == null) {
      return client.getLatestBlock(GetLatestBlockRequest());
    }

    final blockRequest = GetBlockByHeightRequest()..height = height;

    return client.getBlockByHeight(blockRequest);
  }

  /// Gets height of latest available block.
  Future<Int64> getBlockHeight() async {
    final response = await this.getBlock();
    return response.block.height;
  }

  /// Executes script pass with [code] at specified [height].
  Future<ExecuteScriptResponse> executeScript(String code, List<CadenceValue> args,
      {Int64 height}) async {
    final client = this.getAccessClient();

    // If height is not specified, we shall use current block height
    var blockHeight = height;
    if (height == null) {
      blockHeight = await this.getBlockHeight();
      print(blockHeight);
    }

    final request = ExecuteScriptAtBlockHeightRequest()
      ..blockHeight = blockHeight
      ..script = utf8.encode(code);

    final encodedArguments = args.map((e) => e.toMessage());
    request.arguments.insertAll(0, encodedArguments);

    return client.executeScriptAtBlockHeight(request);
  }

  /// Decodes result of script execution into Map.
  Map<String, dynamic> decodeResponse(ExecuteScriptResponse response) {
    return jsonDecode(utf8.decode(response.value)) as Map<String, dynamic>;
  }
}


/// TODO: add execution at block id