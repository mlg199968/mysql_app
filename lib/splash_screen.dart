import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysql_app/providers/user_provider.dart';
import 'package:mysql_app/users/fragments/dashboard.dart';
import 'package:mysql_app/users/fragments/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "/splashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUser();
    Provider.of<UserProvider>(context, listen: false).getSubscription();
    Future.delayed(const Duration(milliseconds: 2000), () {
      //GoRouter.of(context).pushReplacementNamed(DashboardScreen.id);
      context.pushReplacementNamed("/");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: const Center(
          child: Text("Splash Screen",style: TextStyle(color: Colors.white,fontSize: 30),),
        ),
      ),
    );
  }
}
