import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jawla_app/screens/main_screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoadingScreen(),
      ),
    );
  }
}
