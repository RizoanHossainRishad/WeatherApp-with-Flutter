import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class ForecastTomorrow extends StatelessWidget {
  List<dynamic>? tomorrowForecasts = [];
  ForecastTomorrow(List<dynamic> tomorrowForecasts) {
    this.tomorrowForecasts = tomorrowForecasts;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 6, offset: Offset.zero),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  "Tomorrow",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),

                  child: Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Text("${tomorrowForecasts!.length}")
                        CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          minRadius: 20,
                          child: Image.network(
                            "https://openweathermap.org/img/wn/${tomorrowForecasts![3]["weather"][0]["icon"]}@2x.png",
                            scale: 2,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Tomorrow",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  Jiffy.parse(
                                    tomorrowForecasts![3]["dt_txt"],
                                  ).format(pattern: 'do MMM'),
                                ),
                                Text(
                                  "${tomorrowForecasts![3]["weather"][0]["description"]}",
                                ),
                              ],
                            ),
                          ),
                        ),

                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                "${tomorrowForecasts![3]["main"]["temp"].round()}°C",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.arrow_upward),
                                  Text(
                                    "${tomorrowForecasts![3]["main"]["temp_max"].round()}°",
                                  ),
                                  Icon(Icons.arrow_downward),
                                  Text(
                                    "${tomorrowForecasts![3]["main"]["temp_min"].round() - 1}°",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tomorrowForecasts!.length,
                  itemBuilder: (context, index) {
                    return/* SingleChildScrollView(
                      child:*/ Card(
                        shadowColor: Colors.grey,
                        color: Colors.white60,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .44,
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                child: Image.network(
                                  "https://openweathermap.org/img/wn/${tomorrowForecasts![index]["weather"][0]["icon"]}@2x.png",
                                  scale: 1.2,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                        Jiffy.parse(
                                          tomorrowForecasts![index]["dt_txt"],
                                        ).format(pattern: 'h:00 a'),
                                      ),

                                      Text(
                                        "${tomorrowForecasts![index]["weather"][0]["main"]}",
                                      ),
                                    ],
                                  ),
                              ),


                              SingleChildScrollView(
                                 child: Text(
                                    "${tomorrowForecasts![index]["main"]["temp"].round()}°C",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),

                            ],
                          ),
                        ),

                      /*),*/
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
