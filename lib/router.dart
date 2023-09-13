import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysql_app/deep_link_handler.dart';
import 'package:mysql_app/payment/pay_screen.dart';
import 'package:mysql_app/splash_screen.dart';
import 'package:mysql_app/users/authentication/login_screen.dart';
import 'package:mysql_app/users/authentication/signup_screen.dart';
import 'package:mysql_app/users/fragments/dashboard.dart';
import 'package:mysql_app/users/fragments/favorite_screen.dart';
import 'package:mysql_app/users/fragments/home_screen.dart';
import 'package:mysql_app/users/fragments/order_screen.dart';
import 'package:mysql_app/users/fragments/profile_screen.dart';

//GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
   GoRouter router = GoRouter(
     initialLocation: SplashScreen.id,
   // redirect: (context, state) {
   //   if (state.uri.path!="/" && state.uri.path!="/splashScreen" ) {
   //     print("redirect activated...");
   //     print(state.uri.path);
   //     print(state.uri.queryParameters);
   //     print("redirect activated...end");
   //     GoRouter.of(context).go(PayScreen.id);
   //   }
   // },
    routes: [
      GoRoute(
          name: "/",
          path: "/",
          pageBuilder: (context, state) {
            return MaterialPage(child: DashboardScreen());
          },),
      GoRoute(
          name: HomeScreen.id,
          path: HomeScreen.id,
          pageBuilder: (context, state) {
            return const MaterialPage(child: HomeScreen());
          }),
      GoRoute(
          name: SplashScreen.id,
          path: SplashScreen.id,
          pageBuilder: (context, state) {
            return const MaterialPage(child: SplashScreen());
          }),
      GoRoute(
          name: FavoriteScreen.id,
          path: FavoriteScreen.id,
          pageBuilder: (context, state) {
            return const MaterialPage(child: FavoriteScreen());
          }),
      GoRoute(
          name: ProfileScreen.id,
          path: ProfileScreen.id,
          pageBuilder: (context, state) {
            return  MaterialPage(child: ProfileScreen(queryData: state.uri.queryParameters,));
          }),
      GoRoute(
          name: OrderScreen.id,
          path: OrderScreen.id,
          pageBuilder: (context, state) {
            return const MaterialPage(child: OrderScreen());
          }),
      GoRoute(
          name: LoginScreen.id,
          path: LoginScreen.id,
          pageBuilder: (context, state) {
            return const MaterialPage(child: LoginScreen());
          }),
      GoRoute(
          name: SignUpScreen.id,
          path: SignUpScreen.id,
          pageBuilder: (context, state) {
            return const MaterialPage(child: SignUpScreen());
          }),
      GoRoute(
          name: PayScreen.id,
          path: PayScreen.id,
          pageBuilder: (context, state) {
            return MaterialPage(
                child: PayScreen(
              queryData: state.uri.queryParameters,
            ));
          }),
    ],
  );


   GoRouter router2 = GoRouter(
    routes: [
      GoRoute(
          name: "splash",
          path: SplashScreen.id,
          builder: (context, state) {
            return const SplashScreen();
          }),
      GoRoute(
        name: "dashboard",
        path: "/",
        builder: (context, state) {
          return  DashboardScreen();
        },),
      GoRoute(
          name: "home",
          path: HomeScreen.id,
          builder: (context, state) {
            return const  HomeScreen();
          }),

      GoRoute(
          name: FavoriteScreen.id,
          path: FavoriteScreen.id,
          builder: (context, state) {
            return const FavoriteScreen();
          }),
      GoRoute(
          name: ProfileScreen.id,
          path: ProfileScreen.id,
          builder: (context, state) {
            return const ProfileScreen();
          }),
      GoRoute(
          name: OrderScreen.id,
          path: OrderScreen.id,
          builder: (context, state) {
            return const OrderScreen();
          }),
      GoRoute(
          name: LoginScreen.id,
          path: LoginScreen.id,
          builder: (context, state) {
            return const LoginScreen();
          }),
      GoRoute(
          name: SignUpScreen.id,
          path: SignUpScreen.id,
          builder: (context, state) {
            return const SignUpScreen();
          }),
      GoRoute(
          name: "pay",
          path: "/payScreen",
          builder: (context, state) {
            return PayScreen(
              queryData: state.uri.queryParameters,
            );
          }),
    ],
  );
}


