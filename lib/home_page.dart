import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Importez les nouvelles pages
import 'scan_page.dart';
import 'history_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  final User? user;

  HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final unselectedIconColor = Color(0xFFBBDEFB);
    final unselectedIconTextColor = Color(0xFFBBDEFB);

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(widget.user!.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0),
                child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
            ),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            String displayName = userData['displayName'] ?? '';

            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Bonjour $displayName !'), // Affiche le prénom de l'utilisateur s'il existe
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                showUnselectedLabels: true, // Affiche le texte pour les icônes non sélectionnées
                selectedItemColor: Colors.blue, // Couleur pour l'icône sélectionnée
                unselectedItemColor: unselectedIconColor, // Couleur pour les icônes non sélectionnées
                unselectedLabelStyle: TextStyle(color: unselectedIconTextColor), // Couleur du texte pour les icônes non sélectionnées
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
                // Inside _HomePageState
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });

                  // Gérer la navigation vers l'onglet sélectionné
                  if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScanPage()),
                    );
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryPage(user: widget.user)), // Pass the user data
                    );
                  } else if (index == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage(user: widget.user)),
                    );
                  }
                },

              ),
            );
          } else {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
              body: Center(
                child: Text('Aucune donnée utilisateur trouvée.'),
              ),
            );
          }
        }
      },
    );
  }
}
