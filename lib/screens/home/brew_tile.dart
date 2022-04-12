import 'dart:ui';

import 'package:flutter/material.dart';
import '../../models/brew.dart';

class BrewTile extends StatelessWidget {
  // const BrewTile({Key? key}) : super(key: key);
  final Brew brew;
  BrewTile({required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.brown[brew.strength],
                backgroundImage: AssetImage('assets/coffee_icon.png'),
              ),
              title: Text(brew.name),
              subtitle: Text('Takes ${brew.sugars} sugar(s)'),
            ),
          ),
        ),
      ),
    );
  }
}
