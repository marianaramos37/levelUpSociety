import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:giveaway_app/wrapper.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Provider<GiveAwayUser>.value(
      value: GiveAwayUser(uid: "a"),
      child: MaterialApp(
        title: 'GiveAway',
        theme: ThemeData(
          // This is the theme of your application.

          primarySwatch: Colors.teal,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,

          textTheme: TextTheme(
            // App Title - white
            headline1: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 45.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Page Title - purple
            headline2: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Color(0xfffc4058),
                fontSize: 32.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Page Subtitle - black
            headline3: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Color(0xFF4A4444),
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Form Buttons
            headline4: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Buttons Text - purple
            headline5: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Color(0xFFff687c),
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Home Buttons Text - white
            headline6: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        home: Wrapper(),
      ),
    );
  }
}
