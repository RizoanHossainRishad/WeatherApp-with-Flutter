
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class ForecastDemo extends StatelessWidget {
  Map<String, dynamic>? forecastMap;
  List<dynamic>? todayForecasts;



  ForecastDemo(Map<String, dynamic>? forecastMap,List<dynamic>? todayForecasts) {
    this.forecastMap = forecastMap!;
    this.todayForecasts=todayForecasts;

  }

  Color TodayCards=Color(0xffddeee8);


  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow:[
            BoxShadow(
              color: Colors.black,
              blurRadius:2,
              offset: Offset(-1,-1),
            )
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            topLeft: Radius.circular(50),
          ),

        ),
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("3 Hour Forecast",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                  ),),
                  ),

                  SizedBox(
                    height:MediaQuery.of(context).size.height*0.18,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: todayForecasts!.length,
                        itemBuilder: (context,index){
                          return Expanded(
                            child: Card(
                              shadowColor: Colors.grey,
                              color: TodayCards,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CircleAvatar(
                                        backgroundColor:Colors.blueGrey,
                                        child: Image.network("https://openweathermap.org/img/wn/${todayForecasts![index]["weather"][0]["icon"]}@2x.png",
                                          scale: 1,
                                        ),
                                      ),
                                    ),
                                    Text(Jiffy.parse(todayForecasts![index]["dt_txt"]).format(pattern: 'h:00 a')),
                                    SingleChildScrollView(
                                      child: Expanded(
                                        child: Text(
                                            "${todayForecasts![index]["main"]["temp"].round()}°C",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                          "${todayForecasts![index]["weather"][0]["main"]}"
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
