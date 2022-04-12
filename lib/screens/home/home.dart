import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guru4cars/models/brew.dart';
import 'package:guru4cars/screens/home/settings_form.dart';
import 'package:guru4cars/screens/name_generator/name_generator.dart';
import 'package:guru4cars/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:guru4cars/services/auth.dart';
import '../../services/database.dart';
import './brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.brown,
          elevation: 30,
          icon: const Icon(Icons.settings),
          label: const Text('Settings'),
          onPressed: () => _showSettingsPanel(),
        ),
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.next_plan,
                color: Colors.white,
              ),
              label: const Text(
                'Sec Page',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NameGenerator()),
                );
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
