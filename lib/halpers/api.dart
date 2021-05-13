import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pinder/halpers/models/detailmodel.dart';
import 'package:pinder/halpers/models/feedmodel.dart';

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
      } else if (response.statusCode == 400) {
        Map data = {
          'isscuses': false,
          'result': response.body,
        };
        return data;
      } else
        return null;
    } catch (e) {
      return null;
    }
  }

  Future<Map> getfeed() async {
    try {
      var urlforsignup = "post/getall";

      Uri nexturi = Uri.parse(baseurl + urlforsignup);

      final response = await http.get(
        nexturi,
      );
      if (response.statusCode == 200) {
        var jsonobject = json.decode(response.body);
        List<FeedModel> feeds = List();

        for (int i = 0; i < jsonobject.length; i++) {
          FeedModel feed = new FeedModel(
              jsonobject[i]["id"].toString(),
              jsonobject[i]["postName"],
              base64Decode(jsonobject[i]["postImage"]));
          feeds.add(feed);
        }
        Map data = {
          'isscuses': true,
          'result': feeds,
        };
        return data;
      } else if (response.statusCode == 400) {
        Map data = {
          'isscuses': false,
          'result': response.body,
        };
        return data;
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map> getdetail(String id) async {
    try {
      var urlforsignup = "post/getbyid?Id=$id";

      Uri nexturi = Uri.parse(baseurl + urlforsignup);
      final response = await http.get(nexturi);

      if (response.statusCode == 200) {
        var jsonobject = json.decode(response.body);
        DetailModel detail = new DetailModel(
            jsonobject["description"],
            jsonobject["prize"],
            jsonobject["telNo"],
            base64Decode(jsonobject["postImage"]));

        Map data = {
          'isscuses': true,
          'result': detail,
        };
        return data;
      } else if (response.statusCode == 400) {
        Map data = {
          'isscuses': false,
          'result': response.body,
        };
        return data;
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map> loginin(String email, String password) async {
    try {
      var urlforsignup = "auth/login";

      Uri nexturi = Uri.parse(baseurl + urlforsignup);

      final response = await http.post(
        nexturi,
        headers: headers,
        body: '''{"Email":"$email","Password":"$password"}''',
      );

      if (response.statusCode == 200) {
        Map data = {
          'isscuses': true,
          'result': response.body,
        };
        return data;
      } else if (response.statusCode == 400) {
        Map data = {
          'isscuses': false,
          'result': response.body,
        };
        return data;
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
