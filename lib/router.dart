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

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: SplashScreen.id,
 //   redirect: (context, state) {
 //     if (state.uri.path!="/" && state.uri.path!="/splashScreen" ) {
 //       print("redirect activated...");
 //       print(state.uri.path);
 //       print(state.uri.queryParameters);
//        print("redirect activated...end");
//return PayScreen.id;
//      }
 //   },
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
            return const MaterialPage(child: ProfileScreen());
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
}

class AppRouter2 {
  static GoRouter router = GoRouter(
    initialLocation: SplashScreen.id,
    routes: [
      GoRoute(
          name: "splash",
          path: SplashScreen.id,
          builder: (context, state) {
            return SplashScreen();
          }),
      GoRoute(
          name: "home",
          path: HomeScreen.id,
          builder: (context, state) {
            return HomeScreen();
          }),
      GoRoute(
          name: "favorite",
          path: FavoriteScreen.id,
          builder: (context, state) {
            return FavoriteScreen();
          }),
      GoRoute(
          name: "profile",
          path: ProfileScreen.id,
          builder: (context, state) {
            return ProfileScreen();
          }),
      GoRoute(
          name: "orders",
          path: OrderScreen.id,
          builder: (context, state) {
            return OrderScreen();
          }),
      GoRoute(
          name: "login",
          path: LoginScreen.id,
          builder: (context, state) {
            return LoginScreen();
          }),
      GoRoute(
          name: "signup",
          path: SignUpScreen.id,
          builder: (context, state) {
            return SignUpScreen();
          }),
      GoRoute(
          name: "pay",
          path: PayScreen.id,
          builder: (context, state) {
            return PayScreen();
          }),
    ],
  );
}
