import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'history_page.dart';
import 'home_page.dart';
import 'scan_page.dart';

class SettingsPage extends StatelessWidget {
  final User? user;

  SettingsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    final unselectedIconColor = Color(0xFFBBDEFB);
    final unselectedIconTextColor = Color(0xFFBBDEFB);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: Center(
        child: Text('Contenu de la page de paramètres'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Set the index for settings page to be selected in bottom navigation bar
        showUnselectedLabels: true, // Affiche le texte pour les icônes non sélectionnées
        selectedItemColor: Colors.blue, // Couleur pour l'icône sélectionnée
        unselectedItemColor: unselectedIconColor, // Couleur pour les icônes non sélectionnées
        unselectedLabelStyle: TextStyle(color: unselectedIconTextColor), // Couleur pour l'icône sélectionnée
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(user: user)),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScanPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryPage(user: user)),
            );
          }
        },
      ),
    );
  }
}
