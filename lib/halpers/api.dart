import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pinder/halpers/models/commentmodel.dart';
import 'package:pinder/halpers/models/detailmodel.dart';
import 'package:pinder/halpers/models/feedmodel.dart';
import 'package:pinder/halpers/models/newpostmodel.dart';
import 'package:pinder/halpers/profilemodel.dart';

import 'models/updatemodel.dart';

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

  Future<Map> addpost(NewPostModel model) async {
    try {
      var urlforsignup = "post/add";

      String userid = box.read("uid");
      Uri nexturi = Uri.parse(baseurl + urlforsignup);

      var response = await http.post(nexturi, body: {
        "PostName": model.explain,
        "Description": model.explain,
        "Prize": model.price,
        "PostImage": model.image,
        "TelNo": model.number,
        "UserId": userid
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
      } else {
        Map data = {
          'isscuses': false,
          'result': response.body,
        };
        return data;
      }
    } catch (e) {
      print(e);
      Map data = {
        'isscuses': false,
        'result': e,
      };
      return data;
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
          FeedModel feed = new FeedModel(jsonobject[i]["id"].toString(),
              jsonobject[i]["postName"], jsonobject[i]["postImage"]);
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
      print(id);
      Uri nexturi = Uri.parse(baseurl + urlforsignup);
      final response = await http.get(nexturi);

      if (response.statusCode == 200) {
        var jsonobject = json.decode(response.body);
        List<CommentModel> comments = List();
        var urlforcomment = "post/getcommentbypostid?postid=$id";
        Uri nexturi = Uri.parse(baseurl + urlforcomment);
        final commentresponse = await http.get(nexturi);
        if (commentresponse.statusCode == 200) {
          var jsonobject = json.decode(commentresponse.body);

          for (int i = 0; i < jsonobject.length; i++) {
            comments.add(CommentModel(jsonobject[i]["userId"].toString(),
                jsonobject[i]["postComment"]));
          }
        }
        print(comments.length);
        DetailModel detail = new DetailModel(
            jsonobject["description"],
            jsonobject["prize"],
            jsonobject["telNo"],
            base64Decode(jsonobject["postImage"]),
            comments);
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

  Future<Map> getuserdata(String id) async {
    try {
      var urlforsignup = "user/getbyid?Id=$id";

      Uri nexturi = Uri.parse(baseurl + urlforsignup);

      final response = await http.get(
        nexturi,
      );

      if (response.statusCode == 200) {
        var jsonobject = json.decode(response.body);
        ProfileModel model = new ProfileModel(
            jsonobject["firstName"],
            jsonobject["lastName"],
            jsonobject["email"],
            jsonobject["userImage"],
            jsonobject["phoneNumber"]);
        Map data = {
          'isscuses': true,
          'result': model,
        };
        box.write("number", jsonobject["phoneNumber"]);
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

  Future<Map> updateuser(UpdateModel model) async {
    try {
      var urlforsignup = "auth/update";

      String userid = box.read("uid");
      Uri nexturi = Uri.parse(baseurl + urlforsignup);

      var response = await http.post(nexturi, body: {
        "Email": model.email,
        "FirstName": model.first,
        "LastName": model.last,
        "UserImage": model.image,
        "TelNo": model.number,
        "Password": model.password,
        "Id": userid,
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
      } else {
        Map data = {
          'isscuses': false,
          'result': response.body,
        };
        return data;
      }
    } catch (e) {
      print(e);
      Map data = {
        'isscuses': false,
        'result': e,
      };
      return data;
    }
  }
}
