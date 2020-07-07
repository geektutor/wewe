import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wewe/facts.dart';
import 'package:wewe/soon.dart';
import 'theme.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'home.dart';

class AppBarTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
                    MaterialPageRoute(builder: (context) => FactTop()),
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
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
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
        body: MyHomePage(),
      ),
    );
  }
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
