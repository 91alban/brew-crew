import 'package:flutter/material.dart';
import 'package:guru4cars/models/user.dart';
import 'package:guru4cars/screens/authenticate/authenticate.dart';
import 'package:guru4cars/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:guru4cars/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);
    print(user);
    //returb home or authen

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
