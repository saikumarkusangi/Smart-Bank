import 'dart:convert';

import 'package:bank/services/constants.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/asymmetric/api.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/rsa.dart';

import 'package:http/http.dart' as http;
import 'package:pointycastle/export.dart';
class NetworkServices {



  static userlogin<UserData>(String nickName, String pinNumber) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "action": "details",
            "nick_name": nickName,
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static createAccount<UserData>(
    String nickName,
    String fullName,
    String pin,
    String mobile,
    String upi,
    String userName,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "action": "register",
          "nick_name": nickName,
          "full_name": fullName,
          "user_name": userName,
          "pin_number": pin,
          "mob_number": mobile,
          "upi_id": "$upi@rpbank"
        }),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static deleteUser<UserData>(String nickName) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"action": "remove", "nick_name": nickName}),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static update<UserData>(String key, value, nickname) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "action": "update",
          'nick_name': nickname.toString(),
          "key": key.toString(),
          "value": value.toString()
        }),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static currentBalance<UserData>(String nickName) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {"action": "balance", "nick_name": nickName.trim()},
        ),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static send<UserData>(String to, int ammount, String from) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "action": "transfer",
            "amount": ammount,
            "from_user": from.trim(),
            "to_user": to.trim()
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static history<UserData>(String nickName) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {"action": "history", "nick_name": nickName},
        ),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }
}
