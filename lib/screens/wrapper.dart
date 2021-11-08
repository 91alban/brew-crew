import 'package:flutter/material.dart';
import 'package:guru4cars/screens/authenticate/authenticate.dart';
import 'package:guru4cars/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //returb home or authen

    return Authenticate();
  }
}
