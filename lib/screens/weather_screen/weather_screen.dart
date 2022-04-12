import 'package:flutter/material.dart';
import 'package:guru4cars/services/weather_api_client.dart';

import '../../models/weather.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherApiClient client = WeatherApiClient();
  Weather? dataDurres;

  Future<void> getDataDurres() async {
    dataDurres = await client.getCurrentWeather("Durres");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          ElevatedButton(
              onPressed: () {
                client.getCurrentWeather("Durres");
              },
              child: Text('Press for weather'))
        ],
      ),
      body: FutureBuilder(
        future: getDataDurres(),
        builder: (context, snapshot) {
          print(dataDurres);
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .6,
                      decoration: BoxDecoration(),
                      child: const Image(
                          color: Colors.black,
                          colorBlendMode: BlendMode.colorBurn,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://de.wander.al/uploads/photos/02ca541ea2ebc61d50e4f90c7c4fe48d.jpg')),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 2 * .85,
                      child: ClipPath(
                        clipper: BackgroundClipper(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .60,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFAFAFA),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .5,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            dataDurres?.cityname ?? 'Nuk ka',
                            style: const TextStyle(
                                fontSize: 26, color: Colors.white),
                            // textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height / 30);
    path.lineTo(size.width, size.height / 4);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
