import 'package:flutter/material.dart';
import 'package:guru4cars/screens/weather_screen/weather_screen.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Menu'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Weather Screen'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeatherScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('My Education'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/education');
            },
          ),
        ],
      ),
    );
  }
}
