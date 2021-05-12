import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class Api {
  final box = GetStorage();
  final String baseurl = "https://www.pinder.xyz/api/";
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Future<Map> createuser(
      String name, String surname, String email, String password) async {
    try {
      var urlforsignup = "auth/register";

      Uri nexturi = Uri.parse(baseurl + urlforsignup);

      final response = await http.post(nexturi, body: {
        "Email": email,
        "FirstName": name,
        "LastName": surname,
        "Password": password,
      });

      if (response.statusCode == 200) {
        Map data = {
          'isscuses': true,
          'result': response.body,
        };
        return data;
      } else {
        Map data = {
          'isscuses': false,
          'result': response.body,
        };
        return data;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> loginin(String email, String password) async {
    try {
      var urlforsignup = "auth/login";

      Uri nexturi = Uri.parse(baseurl + urlforsignup);

      final response = await http.post(
        nexturi,
        headers: headers,
        body: '''{"Email":"$email","Password":"$password"}''',
      );

      if (response.statusCode == 200) {
        return response.body;
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
