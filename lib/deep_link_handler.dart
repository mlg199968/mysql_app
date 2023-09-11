// import 'dart:async';
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mysql_app/router.dart';
// import 'package:uni_links/uni_links.dart';
//
// class DeepLinkHandler {
//   static handler() {
//      StreamSubscription subscription = linkStream.listen((link) {
//       if (link != null) {
//         //https://mlggrand2.ir/#/payScreen?user_id=4235465&Authority=000000235235&Status=OK
//         String fullPath = link
//             .split("mlggrand2.ir/#")
//             .last;
// String route=fullPath.split("?").first;
// Map<String,dynamic> params=Uri.splitQueryString(fullPath.split("?").last);
// AppRouter.router.goNamed(route,queryParameters:params);
//         print("my config...");
//         print(params);
//         print(route);
//       }
//     });
//   }
// }