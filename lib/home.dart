import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var temp, humidity, visibility, description;
  var wind;
  var url, data, response, city, date, tempValue;
  var mainWeather = 'assets/Subtract.png';

  bool isLoading = false;

  weWeather(String value) async {
    setState(() {
      isLoading = true;
    });
    url =
        'http://api.openweathermap.org/data/2.5/weather?q=$value&units=metric&APPID=0c1b6d71bec35b22e23b31daa3645823';
    response = await http.get(url);
    setState(() {
      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        isLoading = false;
        temp = data['main']['temp_max'];
        description = data['weather'][0]['description'];
        mainWeather = data['weather'][0]['main'];
        if (mainWeather == 'Clouds') {
          mainWeather = 'assets/clody icon.png';
        } else if (mainWeather == 'Rain') {
          mainWeather = 'assets/rainny.png';
        } else if (mainWeather == 'Clear') {
          mainWeather = 'assets/Subtract.png';
        } else if (mainWeather == 'Snow') {
          mainWeather = 'assets/041-snowflake.png';
        } else if (mainWeather == 'Thunderstorm') {
          mainWeather = 'assets/044-storm.png';
        } else if (mainWeather == 'Drizzle') {
          mainWeather = 'assets/drizzle.png';
        } else if (mainWeather == 'Atmosphere') {
          mainWeather = 'assets/017-foggy.png';
        } else {
          mainWeather = 'assets/Subtract.png';
        }
        tempValue = data['main']['temp'].toString();
        humidity = data['main']['humidity'];
        wind = data['wind']['speed'];
        visibility = data['visibility'];
        city = data['name'];
        int dateCalc = data['dt'] * 1000;
        date = DateTime.fromMillisecondsSinceEpoch(dateCalc, isUtc: true);
        date = date.year.toString() +
            '-' +
            date.month.toString().padLeft(2, '0') +
            '-' +
            date.day.toString();
      } else {
        isLoading = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: ConstrainedBox(
          constraints: BoxConstraints.tight(screenSize),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: kToolbarHeight + 20,
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                width: 250,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Enter City',
                    contentPadding: EdgeInsets.only(left: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Color(0xFFC4C4C4),
                      ),
                    ),
                  ),
                  onSubmitted: (value) {
                    weWeather(value);
                  },
                ),
              ),
              Spacer(
                flex: 1,
              ),
              isLoading
                  ? Container(child: CircularProgressIndicator())
                  : Container(
                      margin: EdgeInsets.all(20),
                      width: 72,
                      height: 72,
                      child: Image(
                        image: AssetImage('$mainWeather'),
                      ),
                    ),
              Text(
                '$tempValue\u00B0' == 'null\u00B0'
                    ? '0\u00B0'
                    : '$tempValue\u00B0',
                style: GoogleFonts.ubuntu(
                  textStyle:
                      TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '$description' == 'null' ? '' : '$description',
                style: GoogleFonts.ubuntu(
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                '$city' == 'null' ? '' : '$city',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(fontSize: 24),
                ),
              ),
              Text(
                '$date' == 'null' ? ' ' : '$date',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(fontSize: 14),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Result(
                      'assets/049-thermometer.png',
                      'Temperature',
                      '$temp\u00B0' == 'null\u00B0'
                          ? '0\u00B0'
                          : '$temp\u00B0'),
                  SizedBox(
                    width: 10,
                  ),
                  Result('assets/humidity 1.png', 'Humidity',
                      '$humidity %' == 'null %' ? '0 %' : '$humidity%'),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Result('assets/058-wind.png', 'Wind',
                      '$wind m/h' == 'null m/h' ? '0 m/h' : '$wind m/h'),
                  SizedBox(
                    width: 10,
                  ),
                  Result(
                      'assets/020-foggy.png',
                      'Visibility',
                      '$visibility km' == 'null km'
                          ? '0 km'
                          : '$visibility km'),
                ],
              ),
              Spacer(
                flex: 2,
              ),
            ],
          )),
    );
  }
}

class Result extends StatelessWidget {
  Result(this.imageShow, this.name, this.response);
  String imageShow, name, response;
  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 139,
      height: 139,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Image(
                image: AssetImage(imageShow),
                height: 30,
              ),
            ),
            Text(
              name,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              response,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
