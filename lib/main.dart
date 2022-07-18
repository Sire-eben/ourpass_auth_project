import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ourpass_auth_project/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import 'screens/splash_screen/splashscreen.dart';

Future<void> main() async {
  //initialized firebase dependencies
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        title: 'Firebase Authentication',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
