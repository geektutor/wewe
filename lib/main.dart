import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? darkTheme : lighterTheme;
    return ThemeProvider(
      initTheme: initTheme,
      child: Builder(builder: (context) {
        return MaterialApp(
          theme: ThemeProvider.of(context),
          home: HomePage(),
        );
      }),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'We',
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(fontSize: 20),
                      color: Colors.blue,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'We',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(fontSize: 20),
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ThemeSwitcher(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.brightness_3, size: 25, color: Colors.black),
                  onPressed: () {
                    ThemeSwitcher.of(context).changeTheme(
                      theme: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? darkTheme
                          : lighterTheme,
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var temp, humidity, visibility;
  var wind;
  var url, data, response, city, date, tempValue;

  bool isLoading = false;

  weWeather(String value) async {
    setState(() {
      isLoading = true;
    });
    url =
        'http://api.openweathermap.org/data/2.5/weather?q=$value&units=metric&APPID=0c1b6d71bec35b22e23b31daa3645823';
    response = await http.get(url);
    Timer(Duration(seconds: 5), () {
      setState(() {
        if (response.statusCode == 200) {
          data = convert.jsonDecode(response.body);
          isLoading = false;
          setState(() {
            temp = data['main']['temp_max'];
            tempValue = data['main']['temp'].toString();
            humidity = data['main']['humidity'];
            wind = data['wind']['speed'];
            visibility = data['visibility'];
            city = data['name'];
            int dateCalc = data['dt'] * 1000;
            date = DateTime.fromMillisecondsSinceEpoch(dateCalc, isUtc: true);
            date = date.year.toString() +
                '-' +
                date.month.toString() +
                '-' +
                date.day.toString();
          });
        } else {
          weWeather('Lagos');
        }
      });
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
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter city',
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                  onSubmitted: (value) {
                    weWeather(value);
                  },
                ),
              ),
              Spacer(
                flex: 1,
              ),
              if (isLoading) CircularProgressIndicator(),
              Container(
                margin: EdgeInsets.all(20),
                width: 72,
                height: 72,
                child: Image(
                  image: AssetImage('assets/Subtract.png'),
                ),
              ),
              Text(
                '$tempValue\u00B0' == 'null\u00B0'
                    ? '0\u00B0'
                    : '$tempValue\u00B0',
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(fontSize: 48),
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
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            Text(
              response,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
