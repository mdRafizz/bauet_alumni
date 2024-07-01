import 'package:alumni2/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyClKyIC_-v4tBBSbL0BnUot4dU9JoLRDnY",
        authDomain: "bauet-alumni-3504f.firebaseapp.com",
        projectId: "bauet-alumni-3504f",
        storageBucket: "bauet-alumni-3504f.appspot.com",
        messagingSenderId: "175840290635",
        appId: "1:175840290635:web:a0d398eb2600ba0f38aace",
        measurementId: "G-0R52Q4ZLVQ",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BAUET Alumni Association',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: CupertinoColors.systemGrey6,
        fontFamily: 'poppins',
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thickness: WidgetStateProperty.all(2.5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      getPages: WebRoute.route,
      initialRoute: '/',
      // home: const SignUpNew(),
      // home: const LoginMain(),
      // home: const DataUpload(),
      // home: const EditProfile(),
    );
  }
}
