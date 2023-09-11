import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysql_app/consts/constants.dart';
import 'package:mysql_app/payment/pay_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteScreen extends StatelessWidget {
  static const String id = "/favoriteScreen";

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    (kFavoriteHeader2),
                  ),
                ),
              ),
              height: 300,
              width: double.maxFinite,
              child: const Center(
                  child: Text(
                "Favorite Screen",
                style: TextStyle(color: Colors.white, fontSize: 30),
              )),
            ),
            const Text("Favorite Screen"),
            ElevatedButton(
                onPressed: () {
                  context.pushNamed(PayScreen.id);
                 // GoRouter.of(context).pushNamed(PayScreen.id,pathParameters: {'passName':'MLG Pass Name'});
                },
                child: const Text("Go to pay screen"),),
          SizedBox(height: 100,),
          ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse("https://mlggrand2.ir/payScreen?user_id=4235465&Authority=000000235235&Status=OK"),
                      mode: LaunchMode.externalApplication);
                },
                child: const Text("Go to web test"),),
          ],
        ),
      ),
    );
  }
}

//adb shell 'am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "https://mlggrand2.ir/#/payScreen"'
