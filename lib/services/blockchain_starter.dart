import 'dart:convert';

import 'package:blockchain_starter/models/settings.dart';
import 'package:flutter/services.dart';

const blockchainStarterChannel = const MethodChannel("blockchain.starter/utils");

const MethodPrintTextInConsole = "PrintTextInConsole";
const MethodSaveSettings = "SaveSettings";
const MethodLoadSettings = "LoadSettings";

Future<String> printTextInConsole(String text) async {
  final result =
      await blockchainStarterChannel.invokeMethod(MethodPrintTextInConsole, text);

  print(result);
  return result;
}

Future<Settings> saveSettings(
    String chainId, String address, String privateKey) async {
  final result = await blockchainStarterChannel.invokeMethod(MethodSaveSettings,
      '{"chainId": "$chainId", "address": "$address", "privateKey":"$privateKey"}');

  print(result);
  return Settings.fromJson(jsonDecode(result));
}
