import 'package:flutter/material.dart';
import 'package:guru4cars/services/weather_api_client.dart';
import 'package:intl/intl.dart';

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
        title: const Text('Weather'),
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
          print('weather data $dataDurres');
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .6,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://de.wander.al/uploads/photos/02ca541ea2ebc61d50e4f90c7c4fe48d.jpg'),
                            colorFilter: ColorFilter.mode(
                                Colors.black38, BlendMode.darken)),
                      ),
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
                      height: MediaQuery.of(context).size.height * .4,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .1,
                          ),
                          Text(
                            dataDurres?.cityname ?? 'Nuk ka',
                            style: const TextStyle(
                                fontSize: 26, color: Colors.white),
                            // textAlign: TextAlign.center,
                          ),
                          Text(
                            '${dataDurres?.weather_type.toString()}, ${DateFormat('EEEE').format(DateTime.now()).toString()}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            '${dataDurres?.temp} °C',
                            style: TextStyle(color: Colors.white, fontSize: 56),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('Additional Information'),
                ),
                Divider(),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text('Wind'),
                              SizedBox(width: 20),
                              Text('${dataDurres?.wind.toString()}'),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text('Humidity'),
                              SizedBox(width: 20),
                              Text('${dataDurres?.humidity.toString()}'),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text('Pressure'),
                              SizedBox(width: 20),
                              Text('${dataDurres?.pressure.toString()}'),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text('Feels Like'),
                              SizedBox(width: 20),
                              Text('${dataDurres?.feels_like.toString()}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Container(
                //   height: 50,
                //   child: GridView.count(
                //     crossAxisCount: 2,
                //     mainAxisSpacing: 30,
                //     children: [
                //       ListTile(
                //         title: Text('Wind'),
                //         trailing: Text('${dataDurres?.wind.toString()}'),
                //       ),
                //       ListTile(
                //         title: Text('Humidity'),
                //         trailing: Text('${dataDurres?.humidity.toString()}'),
                //       ),
                //       ListTile(
                //         title: Text('Pressure'),
                //         trailing: Text('${dataDurres?.pressure.toString()}'),
                //       ),
                //       ListTile(
                //         title: Text('Feels Like'),
                //         trailing: Text('${dataDurres?.feels_like.toString()}'),
                //       ),
                //     ],
                //   ),
                // )
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
