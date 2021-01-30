// This package will provide a syntactic sugar on top of generated protobuf files
import 'dart:developer';
import 'package:convert/convert.dart';

import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

// Flow protobuf
import 'package:mini_flow/generated/flow/access/access.pb.dart';
import 'package:mini_flow/generated/flow/access/access.pbgrpc.dart';
import 'package:mini_flow/generated/flow/execution/execution.pbgrpc.dart';

class SugarFlow {
  String endPoint;
  int port;
  ClientChannelBase channel;

  AccessAPIClient accessClient;
  ExecutionAPIClient executionClient;

  static const String MOBILE_EMULATOR_ENDPOINT = '10.0.2.2';
  static const int FLOW_EMULATOR_PORT = 3569;

  SugarFlow(this.endPoint, this.port) {
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

  Future<void> getAccountBalance(String address) async {
    final request = GetAccountAtLatestBlockRequest()
      ..address = hex.decode(address);
    final response = await this.accessClient.getAccountAtLatestBlock(request);
    log(response.toString());
  }
}
