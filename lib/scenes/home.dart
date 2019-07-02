import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_view/flutter_web_view.dart';
import 'package:launch_review/launch_review.dart';
import 'package:math_puzzle/utils/util.dart';
import 'package:math_puzzle/scenes/game.dart';
import 'package:math_puzzle/utils/constants.dart';

class HomePage extends StatefulWidget {
  Image logo;

  HomePage() {}

  @override
  State<StatefulWidget> createState() {
    logo = new Image.asset("assets/logo.png");
    return _HomePage(logo);
  }
}

class _HomePage extends State<HomePage> {
  Image logo;

  FlutterWebView flutterWebView;

  _HomePage(this.logo) {
    flutterWebView = new FlutterWebView();
  }

  void openPrivacyPolicy() {
    flutterWebView.launch(
        "https://sahinegilmez.github.io/SiirhanePoems/privacy_policy_math_puzzle.html",
        headers: {
          "X-SOME-HEADER": "MyCustomHeader",
        },
        javaScriptEnabled: false,
        toolbarActions: [new ToolbarAction("Dismiss", 1)],
        barColor: Colors.green,
        tintColor: Colors.white);
    flutterWebView.onToolbarAction.listen((identifier) {
      switch (identifier) {
        case 1:
          flutterWebView.dismiss();
          break;
      }
    });
    flutterWebView.onWebViewDidStartLoading.listen((url) {
      setState(() {});
    });
    flutterWebView.onWebViewDidLoad.listen((url) {
      setState(() {});
    });
    flutterWebView.onRedirect.listen((url) {
      flutterWebView.dismiss();
      setState(() => {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(children: <Widget>[
        Scaffold(
            backgroundColor: Constants.BACKGROUND_COLOR,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(50),
                          child: Container(
                              alignment: Alignment.topCenter,
                              height: 200,
                              width: 200,
                              child: this.logo),
                        ),
                        Padding(
                            padding: EdgeInsets.all(0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GamePage(Constants.PLUS)),
                                );
                              },
                              child: new Container(
                                child: Center(
                                  child: Text(
                                    "Play Addition Puzzle",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Constants.TRANSPARENT_WHITE),
                                  ),
                                ),
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GamePage(Constants.MULT)),
                                );
                              },
                              child: new Container(
                                child: Center(
                                  child: Text(
                                    "Play Multiplication Puzzle",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Constants.TRANSPARENT_WHITE),
                                  ),
                                ),
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.black54,
                                  ),
                                  iconSize: 50,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // return object of type Dialog
                                        return AlertDialog(
                                          title: new Text("Info"),
                                          backgroundColor: Colors.white,
                                          content: new SingleChildScrollView(
                                            child: new Text(
                                                Constants.DEVELOPER_INFO),
                                          ),
                                          actions: <Widget>[
                                            // usually buttons at the bottom of the dialog
                                            new FlatButton(
                                              child: new Text("Close"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.help_outline,
                                    color: Colors.black54,
                                  ),
                                  iconSize: 50,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // return object of type Dialog
                                        return AlertDialog(
                                          title: new Text("How to play?"),
                                          backgroundColor: Colors.white,
                                          content: new SingleChildScrollView(
                                            child:
                                                new Text(Constants.GAME_INFO),
                                          ),
                                          actions: <Widget>[
                                            new FlatButton(
                                              child: new Text(
                                                  "Open Privacy Policy"),
                                              onPressed: () {
                                                openPrivacyPolicy();
                                              },
                                            ),
                                            new FlatButton(
                                              child: new Text("Close"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.star_border,
                                    color: Colors.black54,
                                  ),
                                  iconSize: 50,
                                  onPressed: () {
                                    LaunchReview.launch();
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                ],
              ),
            )),
      ]),
    );
  }
}
