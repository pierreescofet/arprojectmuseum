import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importez cette bibliothèque

import 'home_page.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instanciez Firestore

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Créer un compte')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'Prénom'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _signUp(context);
              },
              child: Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Enregistrez le prénom et le mot de passe dans Firebase Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email' : _emailController.text,
        'displayName': _firstNameController.text,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: userCredential.user,
          ),
        ),
      );
    } catch (e) {
      print("Erreur de création de compte : $e");
    }
  }
}
