import 'dart:convert';

class Settings {
  String chainId;
  String address;
  String privateKey;

  Settings(this.chainId, this.address, this.privateKey);

  Settings.fromJson(Map<String, dynamic> json)
      : chainId = json['chainId'],
        address = json['address'],
        privateKey = json['privateKey'];
}
