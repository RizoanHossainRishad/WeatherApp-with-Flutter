
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class CurrentDayInfo extends StatelessWidget {
  Map<String, dynamic>? weatherMap;

  CurrentDayInfo(Map<String, dynamic>? weatherMap){
    this.weatherMap=weatherMap;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: 300,
                      child: Text(
                        "${weatherMap!["main"]["temp"]!.round()}°C",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 120,
                            letterSpacing: 2,
                            color: Colors.white,
                            shadows:shadowStyleBold(),
                            // Optional: ensure contrast
                          ),
                        ),
                      ),
                    ),
                  ),

                  RotatedBox(
                    quarterTurns: -1,
                    child: Row(
                      children: [
                        Image.network(
                          "https://openweathermap.org/img/wn/${weatherMap!["weather"][0]["icon"]}@2x.png",
                          scale: 1.5,
                        ),
                        Text(
                          "${weatherMap!["weather"][0]["description"]!}"
                              .toString()
                              .toLowerCase()
                              .replaceFirstMapped(
                            RegExp(r'^[a-z]'),
                                (match) => match
                                .group(0)!
                                .toUpperCase(),
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            shadows: shadowStyleBold(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.black,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.02),
                        borderRadius: BorderRadius.circular(
                            15
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            weight: 5,
                            color: Colors.white,
                            shadows:shadowStyleBold(),
                          ),
                          Text(
                            "${weatherMap!["main"]["temp_max"]!}°C  ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 3, height: 30),
                          Icon(
                            Icons.arrow_downward,
                            weight: 5,
                            color: Colors.white,
                            shadows: shadowStyleBold(),
                          ),

                          Text(
                            " ${weatherMap!["main"]["temp_min"]! - 2}°C",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class CurrentDay extends StatelessWidget {
  Map<String, dynamic>? weatherMap;
  CurrentDay(Map<String, dynamic>? weatherMap){
    this.weatherMap=weatherMap;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(
              25
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Feels Like",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white54,
                        ),
                      ),
                      Text(
                        " ${weatherMap!["main"]["feels_like"]!}°",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Humidity",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white54,
                        ),
                      ),
                      Text(
                        " ${weatherMap!["main"]["humidity"]!}%",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Pressure",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white54,
                        ),
                      ),
                      Text(
                        " ${weatherMap!["main"]["pressure"]!}hPa",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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