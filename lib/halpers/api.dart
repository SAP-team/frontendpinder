import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pinder/halpers/models/commentmodel.dart';
import 'package:pinder/halpers/models/detailmodel.dart';
import 'package:pinder/halpers/models/feedmodel.dart';
import 'package:pinder/halpers/models/newcommentmode.dart';
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
              jsonobject[i]["description"], jsonobject[i]["postImage"]);
          feeds.add(feed);
        }
        Map data = {
          'isscuses': true,
          'result': feeds.reversed.toList(),
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
        List<CommentModel> comments = List();
        var urlforcomment = "post/getcommentbypostid?postid=$id";
        Uri nexturi = Uri.parse(baseurl + urlforcomment);
        final commentresponse = await http.get(nexturi);
        if (commentresponse.statusCode == 200) {
          var jsonobject = json.decode(commentresponse.body);

          for (int i = 0; i < jsonobject.length; i++) {
            var urlforimage =
                "comment/getimagebyuserid?userid=${jsonobject[i]["userId"]}";
            Uri urlfforimage = Uri.parse(baseurl + urlforimage);
            final respsonseforiamge = await http.get(urlfforimage);

            if (respsonseforiamge.statusCode == 200) {
              comments.add(CommentModel(
                  jsonobject[i]["userId"].toString(),
                  jsonobject[i]["postComment"],
                  base64Decode(respsonseforiamge.body)));
            } else
              comments.add(CommentModel(jsonobject[i]["userId"].toString(),
                  jsonobject[i]["postComment"], null));
          }
        }
        String image = "", name = "";
        var urlforpostownerdata = "user/getbyid?Id=${jsonobject["userId"]}";
        Uri foruserdata = Uri.parse(baseurl + urlforpostownerdata);
        final foruserdataresponse = await http.get(foruserdata);
        if (foruserdataresponse.statusCode == 200) {
          var jsonfodata = json.decode(foruserdataresponse.body);
          name = jsonfodata["firstName"];
          image = jsonfodata["userImage"];
        }
        DetailModel detail = new DetailModel(
            jsonobject["description"],
            jsonobject["prize"],
            jsonobject["telNo"],
            base64Decode(jsonobject["postImage"]),
            comments,
            name,
            image != null ? base64Decode(image) : null,
            id);
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
          jsonobject["firstName"] ?? "",
          jsonobject["lastName"] ?? "",
          jsonobject["email"] ?? "",
          jsonobject["phoneNumber"] ?? "",
          jsonobject["userImage"] ?? "",
        );
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
        "Email": model.email ?? "",
        "FirstName": model.first ?? "",
        "LastName": model.last ?? "",
        "UserImage": model.image ?? "",
        "PhoneNumber": model.number ?? "",
        "Password": model.password ?? "",
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

  Future<Map> addcoments(NewCommentModel model) async {
    try {
      var urlforaddcomment = "comment/add";

      Uri nexturi = Uri.parse(baseurl + urlforaddcomment);
      final response = await http.post(
        nexturi,
        headers: headers,
        body:
            '''{"PostComment":"${model.postcomment}","UserId":${model.userid},"PostId":${model.postid}}''',
      );

      if (response.statusCode == 200) {
        Map data = {
          'isscuses': true,
          'result': model.postid,
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
