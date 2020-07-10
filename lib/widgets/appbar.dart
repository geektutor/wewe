import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wewe/soon.dart';
import 'package:wewe/weather_facts.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../theme.dart';
import 'spacing.dart';

class AppBarTop extends StatelessWidget {
  final Widget child;
  final Widget drawer;

  const AppBarTop({Key key, this.child, this.drawer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        //extendBodyBehindAppBar: true,
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(''),
                decoration: BoxDecoration(),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).buttonColor,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Theme.of(context).buttonColor,
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.explore,
                  color: Theme.of(context).buttonColor,
                ),
                title: Text(
                  'Weather Explorer',
                  style: TextStyle(
                    color: Theme.of(context).buttonColor,
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.error_outline,
                  color: Theme.of(context).buttonColor,
                ),
                title: Text(
                  'Interesting Facts',
                  style: TextStyle(
                    color: Theme.of(context).buttonColor,
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherFacts()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).buttonColor,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    color: Theme.of(context).buttonColor,
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComingSoonTop()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.chat_bubble_outline,
                  color: Theme.of(context).buttonColor,
                ),
                title: Text(
                  'Help & Feedback',
                  style: TextStyle(
                    color: Theme.of(context).buttonColor,
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: CustomAppBar(),
        body: child,
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
          onTap: (){
            print("clicked");
            Scaffold.of(context).openDrawer();
          },
          child: Container(
            padding: EdgeInsets.only(left: 10),
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 3,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryIconTheme.color,
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                YMargin(10),
                Container(
                  height: 3,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryIconTheme.color,
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ],
            ),
          ),
        ),
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "WeWe",
              style: GoogleFonts.nunito(
                textStyle: TextStyle(fontSize: 28),
                color: Color(0xff19BF69),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: <Widget>[
            ThemeSwitcher(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.brightness_3, size: 25),
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
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
            ),
          ],
        ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 50);
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (query.length < 3) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "Search term must be longer than two letters.",
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container(
      child: Text('E good o'),
    );
  }
}
