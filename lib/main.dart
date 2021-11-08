import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guru4cars/models/user.dart';
import 'package:guru4cars/screens/wrapper.dart';
import 'package:guru4cars/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData?>.value(
      initialData: null,
      value: AuthService().user,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
