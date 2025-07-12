import 'dart:convert';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'ForecastTomorrow.dart';
import 'current_day_info.dart';
import 'forecast_demo.dart';
import 'other_forecasts_demo.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    position = await Geolocator.getCurrentPosition();
    getWeather();
    //print("MY latitude is: ${position!.latitude} and Longitude is : ${position!.longitude}",);
    //print("${position!.timestamp}");
  }

  Position? position;
  @override
  void initState() {
    determinePosition();
    super.initState();
  }

  Map<String, dynamic>? weatherMap;
  Map<String, dynamic>? forecastMap;
  List<dynamic> tomorrowForecasts = [];
  List<dynamic> todayForecasts = [];
  List<dynamic> originalList = [];

  getWeather() async {
    var weather = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${position!.latitude}&lon=${position!.longitude}&appid=d5166e37f5f9b82e4d33ed2b6da82dd1&units=metric",
      ),
    );
    //print("Weather Data is ${weather.body}");
    // print("========================================================");
    var forecast = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?lat=${position!.latitude}&lon=${position!.longitude}&appid=d5166e37f5f9b82e4d33ed2b6da82dd1&units=metric",
      ),
    );
    var weatherData = jsonDecode(weather.body);
    var forecastData = jsonDecode(forecast.body);
    // print("Forecast Data is ${forecast.body}");

    setState(() {
      weatherMap = Map<String, dynamic>.from(weatherData);
      //weatherMap=Map<String,dynamic>.from(jsonDecode(weatherData)); We can also do this
      forecastMap = Map<String, dynamic>.from(forecastData);
      originalList= List.from(forecastMap!["list"]);
      if (forecastMap?["list"] != null) {
        DateTime now = DateTime.now();
        String todayStr = Jiffy.parse('${DateTime.now()}',).format(pattern: 'MMM do').toString();

        var date1 = Jiffy.parse('${DateTime.now()}').format(pattern:'d');
        int todayInt = int.parse(date1);

        for (var item in forecastMap!["list"]) {
          String dtTxt = Jiffy.parse(
            '${item["dt_txt"]}',
          ).format(pattern: 'MMM do').toString();
          var date = Jiffy.parse('${item["dt_txt"]}').format(pattern:'d');
          int dayAsInt = int.parse(date);
          if (dtTxt.startsWith(todayStr)) {

            todayForecasts.add(item);

          }else if(todayInt + 1 == dayAsInt) {
            tomorrowForecasts.add(item);
          }
        }

        originalList = forecastMap!["list"].where((item) {

          String dtTxt = Jiffy.parse('${item["dt_txt"]}').format(pattern: 'MMM do').toString();
          var date = Jiffy.parse('${item["dt_txt"]}').format(pattern:'d');
          int dayAsInt = int.parse(date);
          return !dtTxt.startsWith(todayStr) && (todayInt + 1 != dayAsInt) && (todayInt<dayAsInt);
        }).toList();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: weatherMap != null
          ? Scaffold(
        body: Stack(
          children: [
            Image.asset(
              // Inline condition using Jiffy
              (Jiffy.now().hour >= 5 && Jiffy.now().hour < 18)
                  ? 'images/morning_background.jpg'
                  : 'images/background.jpg',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  expandedHeight:
                  MediaQuery.of(context).size.height * 0.01,
                  flexibleSpace: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.01),
                            borderRadius: BorderRadius.circular(
                                10
                            ),
                          ),// Optional tint
                        ),
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${weatherMap!["name"]!}, ${weatherMap!["sys"]["country"]!} ",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                letterSpacing: 2,
                                color: Colors.white,
                                shadows: shadowStyleBold(),
                              ),
                            ),
                          ),

                          Text(
                            Jiffy.parse(
                              '${DateTime.now()}',
                            ).format(pattern: 'MMM do , h:mm a'),
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                letterSpacing: 2,
                                color: Colors.white,
                                decorationStyle: TextDecorationStyle.wavy,
                                shadows: shadowStyleBold(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Icon(Icons.menu),
                    ],
                  ),
                ),

                SliverToBoxAdapter(child: CurrentDayInfo(weatherMap)),

                SliverToBoxAdapter(child: CurrentDay(weatherMap)),

                SliverToBoxAdapter(
                  child: ForecastDemo(todayForecasts),
                ),
                SliverToBoxAdapter(
                  child: ForecastTomorrow(tomorrowForecasts),
                ),

                SliverToBoxAdapter(
                  child:OtherForecasts(originalList),
                ),
              ],
            ),
          ],
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

List<Shadow> shadowStyleBold() {
  return [
    Shadow(
      // bottomLeft
      offset: Offset(-1.5, -1.5),
      color: Colors.black,
    ),
    Shadow(
      // bottomRight
      offset: Offset(1.5, -1.5),
      color: Colors.black,
    ),
    Shadow(
      // topRight
      offset: Offset(1.5, 1.5),
      color: Colors.black,
    ),
    Shadow(
      // topLeft
      offset: Offset(-1.5, 1.5),
      color: Colors.black,
    ),
  ];
}
