import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jawla_app/extensions/navigators.dart';
import 'my_navigation_bar.dart';

import '../auth_screens/login_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      final box = GetStorage();

      box.hasData("token")
          ? context.push(
              screen: const MyNavigationBar(
              screenIndex: 0,
            ))
          : context.push(screen: const LoginScreen());

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
