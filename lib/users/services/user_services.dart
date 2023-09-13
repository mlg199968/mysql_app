import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_app/consts/constants.dart';
import 'package:mysql_app/models/user.dart';
import 'package:mysql_app/payment/payment_services.dart';
import 'package:mysql_app/providers/user_provider.dart';
import 'package:mysql_app/users/fragments/dashboard.dart';
import 'package:provider/provider.dart';

class UserServices {

  ///validate Email
  static Future validateUserEmail(String email) async {
    try {
      http.Response res =
          await http.post(Uri.parse("$hostUrl/user/validate_email.php"), body: {
        'user_email': email.trim(),
      });

      if (res.statusCode == 200) {
        var resVal = jsonDecode(res.body);
        if (resVal['exists'] == true) {
          Fluttertoast.showToast(msg: "this Email already exists!");
          return false;
        } else {
          return true;
        }
      }
    } catch (e) {
      print("validateUserEmail() function error...$e");
    }
  }


  /// function for register user
  static registerUser(User user,context) async {
    try {
      bool isEmailValidate = await validateUserEmail(user.email);
      if (isEmailValidate) {
        http.Response res = await http
            .post(Uri.parse("$hostUrl/user/signup.php"), body: user.toMap());
        if (res.statusCode == 200) {
          print(res.body);
          var resOfSignUp = jsonDecode(res.body);
          if (resOfSignUp['success'] == true) {
            User userInfo = User.fromMap((resOfSignUp['userData']));
            Fluttertoast.showToast(msg: "User successfully registered!");

              Provider.of<UserProvider>(context,listen: false).setUser(userInfo);
              Navigator.popAndPushNamed(context, DashboardScreen.id);

          } else {
            Fluttertoast.showToast(msg: "Error Occurred,try Again! ");
          }
        }
      }
    } catch (e) {
      print("sign up error...$e");
      Fluttertoast.showToast(msg: "registerUser function error!");
    }
  }



  ///function for to login user
  static userLogin(User user,context) async {
    try {
      PaymentServices paymentServices=PaymentServices();
      http.Response res = await http.post(Uri.parse("$hostUrl/user/login.php"),
         //  headers:{
         //  "Access-Control-Allow-Origin": "*",
         //  "Origin": "https://mlggrand2.ir",
         // // "Access-Control-Allow-Credentials": "true",
         //  "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
         //  "Access-Control-Allow-Methods": "POST, GET, OPTIONS, DELETE"
         //  },
          body: user.toMap());
      if (res.statusCode == 200) {
        var resOfLogin = jsonDecode(res.body);

        if (resOfLogin['success'] == true) {
          User userInfo = User.fromMap((resOfLogin['userData']));

            Fluttertoast.showToast(msg: "User successfully logged in!");
            print("user id is${userInfo.id!}");

              Provider.of<UserProvider>(context,listen: false).setUser(userInfo);
              await paymentServices.readSubscription(context,userInfo.id!);

          Future.delayed(const Duration(milliseconds: 2000));
          if (context.mounted) {
            Navigator.pop(context,false);
          }
        } else {
          Fluttertoast.showToast(
            msg: "email or password is not correct! ",
          );
        }
      }
    } catch (e) {
      print("login error...$e");
      Fluttertoast.showToast(
          msg: "userLogin function error!", backgroundColor: Colors.red);
    }
  }
}
