import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wineprojectfolder/authentication_page.dart';

import 'firebase_options.dart'; // Import de la page d'authentification

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Set this to false to remove the debug banner
      home: AuthenticationPage(), // Utilisation de la page d'authentification comme page d'accueil
    );
  }
}
