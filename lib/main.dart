import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:math_puzzle/scenes/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MaterialApp(
      title: 'Math Puzzle',
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'StarJedi'),
      home: HomeScene(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
    );
  }
}
