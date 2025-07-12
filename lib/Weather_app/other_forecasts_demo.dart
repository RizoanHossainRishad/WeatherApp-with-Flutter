import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class OtherForecasts extends StatelessWidget {
  List<dynamic> originalList = [];
  OtherForecasts(List<dynamic> originalList) {
    this.originalList = originalList;
  }
  Color c = Color(0xfffff9ea);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    "More Forecasts",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 1, // Define height
                  child: ListView.builder(
                    itemCount: originalList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: double.infinity,
                         // Define height,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey,
                              style: BorderStyle.solid,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                spreadRadius: 1,
                                offset: Offset(1, 2),
                              ),
                            ],
                            color: c,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                            offset: Offset(1, 2),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${Jiffy.parse('${originalList[index]["dt_txt"]}').format(pattern: 'do MMMM')}",
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            Text(
                                              "${originalList[index]["weather"][0]["description"]}",
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            Text(
                                              "${Jiffy.parse('${originalList[index]["dt_txt"]}').format(pattern: 'h:mm a')}",
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.white38,
                                      thickness: 3,
                                      height: 2,
                                    ),
                                    SizedBox(height: 5),

                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            1,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white54,
                                              blurRadius: 4,
                                              spreadRadius: 0.5,
                                              offset: Offset(1, 2),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    6.0,
                                                  ),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.grey,
                                                    radius: 20,
                                                    child: Image.network(
                                                      "https://openweathermap.org/img/wn/${originalList[index]["weather"][0]["icon"]}@2x.png",
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    4.0,
                                                  ),
                                                  child: Text(
                                                    "${originalList[index]["weather"][0]["main"]}",
                                                    style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.water_drop_outlined,
                                                      ),

                                                      Text(
                                                        "${originalList[index]["main"]["humidity"]}%",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.thermostat_outlined,
                                                      ),

                                                      Text(
                                                        "${originalList[index]["main"]["pressure"]}hPa",
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),


                                            Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: SingleChildScrollView(

                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${originalList[index]["main"]["temp"].round()}°C",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.arrow_upward,
                                                        ),
                                                        Text(
                                                          "${originalList[index]["main"]["temp_max"].round()}°",
                                                        ),
                                                        Icon(
                                                          Icons.arrow_downward,
                                                        ),
                                                        Text(
                                                          "${originalList[index]["main"]["temp_min"].round() - 1}°",
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
