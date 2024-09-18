import 'dart:convert';
import 'package:amazon_clone/View/homeScreen.dart';
import 'package:amazon_clone/constant/global.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/utils/errorhandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/userModel.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future<void> signUpUser(
      {required BuildContext context,
      required String email,
      required String name,
      required String password}) async {
    try {
      User user = User(
          id: '',
          email: email,
          name: name,
          password: password,
          address: '',
          type: '',
          stamp: '');
      http.Response res = await http.post(Uri.parse("$uri/api/signup"),
          body: jsonEncode(user.fromAppToDB()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
          });
      httpErrorHandler(
          context: context,
          response: res,
          onsuccess: () {
            showSnackBar(context,
                "Account Created Successfully! Please login with same credential.");
          });
    } catch (e) {
      showSnackBar(context, "Error Occured : ${e.toString()}");
    }
  }

  Future<void> signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandler(
          response: res,
          context: context,
          onsuccess: () async {
            showSnackBar(context, "Welcome Back!");

            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            print("STAMP VALUE IS HERE");
            print(jsonDecode(res.body)['stamp']);
            await sharedPreferences.setString(
                "stamp", jsonDecode(res.body)['stamp']);
            Navigator.pushNamedAndRemoveUntil(
                context, Homescreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, "Error Occured - ${e.toString()}");
    }
  }

  Future<void> fetchUserData(BuildContext context) async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String? stamp = sharedpreferences.getString("stamp");
    print("Saved Stamp Value");
    print(stamp);
    if (stamp == null) {
      await sharedpreferences.setString("stamp", "");
    }

    var stampRes = await http.post(
      Uri.parse("$uri/validateStamp"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'stamp': stamp!,
      },
    );

    var response = jsonDecode(stampRes.body);
    if (response == true) {
      http.Response userRes = await http.get(
        Uri.parse("$uri/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'stamp': stamp,
        },
      );

      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(userRes.body);
    }
  }
}
