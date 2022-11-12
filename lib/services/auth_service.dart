import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat/classes/login_response.dart';
import 'package:flutter_chat/classes/user.dart';
import 'package:flutter_chat/global/environments.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  late User user;
  bool _startAuth = false;
  final _storage = const FlutterSecureStorage();

  bool get startAuth => _startAuth;
  set startAuth(bool value) {
    _startAuth = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    startAuth = true;

    final data = {'email': email, 'password': password};

    var url = Uri.parse('${Environments.apiUrl}/login');

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    startAuth = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    startAuth = true;

    final data = {'name': name, 'email': email, 'password': password};
    var url = Uri.parse('${Environments.apiUrl}/login/new');

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    startAuth = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLogged() async {
    final token = await _storage.read(key: 'token') ?? '';

    var url = Uri.parse('${Environments.apiUrl}/login/renewToken');

    final resp = await http.get(url,
        headers: {'Content-Type': 'application/json', 'x-token': token});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      _deleteToken();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _deleteToken() async {
    return await _storage.delete(key: 'token');
  }
}
