import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';
import 'package:wewe/widgets/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:wewe/widgets/spacing.dart';


class WeatherFacts extends StatefulWidget {

  const WeatherFacts({Key key}) : super(key: key);

  @override
  _WeatherFactsState createState() => _WeatherFactsState();
}

class _WeatherFactsState extends State<WeatherFacts> { 
   PageController _pageViewController = new PageController(
     viewportFraction: 0.8
   );
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return 
      AppBarTop(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Interesting Weather Facts",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                YMargin(50),
                FutureBuilder<http.Response>(
                  future: http.get("https://raw.githubusercontent.com/geektutor/wewe/master/facts.json"),
                  builder: (context, snapshot){
                    switch (snapshot.connectionState){
                      case ConnectionState.waiting: {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(30),
                              height: 100,
                              width: 100,
                              child: CircularProgressIndicator(),
                            )
                          ],
                        );
                      }
                      break;
              
                      case ConnectionState.done:{
                        if (snapshot.hasError){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "An error occured!",
                                style: Theme.of(context).textTheme.bodyText1.copyWith(
                                  color: Colors.red,
                                  fontSize: 30
                                ),
                              )
                            ],
                          );
                        }
                        else{
                          List<dynamic> facts = (jsonDecode(snapshot.data.body) as Map<String,dynamic>)["facts"];
                          print(snapshot.data.body);
                          return Container(
                          height: getScreenHeight(context) * 0.8,
                            child: PageView(
                              controller: _pageViewController,
                              children: facts.map((fact){
                                return WeatherFactPage(
                                  fact: fact,
                                );
                              }).toList(),
                            ),
                          );
                        }
                      }
                      break;                          
                    }
                  }
                )
              ],
            ),
          ),
          );
  }
}

class WeatherFactAssets {
  String imagePath;
  Color bgColor;

  WeatherFactAssets({@required imagePath, @required bgColor}){
    this.imagePath = imagePath;
    this.bgColor = bgColor;
  }

  WeatherFactAssets.fromFact(String fact){
    if (fact.toLowerCase().contains("rain")){
      this.imagePath = "assets/rain.jpg";
      this.bgColor = Colors.grey[200];
    } 
    else if (fact.toLowerCase().contains("sun")){
      this.imagePath = "assets/sun.jpg";
      this.bgColor = Colors.yellow[100];
    }
    else if (fact.toLowerCase().contains("wind")){
      this.imagePath = "assets/wind.jpg";
      this.bgColor = Colors.blue[100];
    }
    else if (fact.toLowerCase().contains("water")){
      this.imagePath = "assets/sea.jpg";
      this.bgColor = Colors.blue[100];
    }
    else if (fact.toLowerCase().contains("lightning") || fact.contains("thunder")){
      this.imagePath = "assets/lightning.jpg";
      this.bgColor = Colors.blue[100];
    }
    else if (fact.toLowerCase().contains("snow")){
      this.imagePath = "assets/snow.jpg";
      this.bgColor = Colors.blue[100];
    }
    else if (fact.toLowerCase().contains("autumn")){
      this.imagePath = "assets/autumn.jpg";
      this.bgColor = Colors.orange[100];
    }
    else if (fact.toLowerCase().contains("tornado")){
      this.imagePath = "assets/tornado.jpg";
      this.bgColor = Colors.orange[100];
    }
    else {
      this.imagePath = "assets/default.jpg";
      this.bgColor = Colors.blue[100]; // or 100
    }
  }

  
}


class WeatherFactPage extends StatelessWidget {
  final String fact;
  WeatherFactPage({Key key, this.fact});
  @override
  Widget build(BuildContext context) {
    WeatherFactAssets _weatherFactAssets = WeatherFactAssets.fromFact(this.fact);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right:20),
          height: 500,
          width:300,
          
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight:  Radius.circular(20)),
                
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight:  Radius.circular(20)),
                  child: FadeInImage(
                    placeholder: AssetImage(
                      "assets/WeWe.png"
                    ),
                    image: AssetImage(
                      _weatherFactAssets.imagePath,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: _weatherFactAssets.bgColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight:  Radius.circular(20)),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Do you know?",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            
                          ),
                        ),
                        YMargin(25),
                        Text(
                          fact,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                            height: 1.5
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),

        ),
        YMargin(20),
        FlatButton(
          onPressed: (){
            SocialShare.shareOptions("Did you know?\n\n" + fact + "\n\nFind out more on WeWe: https://play.google.com/store/apps/details?id=geektutor.wewe&hl=en");
          },
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          color: Color(0xffD1F2E1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text(
            "Share Flashcard",
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: 18,
              color: Color(0xff19BF69)
            ),
          )
        )
      ],
    );
  }
}

