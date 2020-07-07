import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

class ComingSoonTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
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
          ],
        ),
        body: ComingSoon(),
      ),
    );
  }
}

class ComingSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Coming Soon',
            style: GoogleFonts.nunito(
              textStyle: TextStyle(fontSize: 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset('assets/coming.png'),
          Text(
            'There’s a special surprise for our users.\nWe are cooking up something very exciting.',
            style: GoogleFonts.nunito(
              textStyle: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
