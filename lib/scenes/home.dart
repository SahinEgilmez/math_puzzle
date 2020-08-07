import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:launch_review/launch_review.dart';
import 'package:math_puzzle/scenes/game.dart';
import 'package:math_puzzle/utils/ads.dart';
import 'package:math_puzzle/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScene extends StatefulWidget {
  final Image logo = new Image.asset("assets/logo.png");

  HomeScene() {
    Ads.initialize();
  }

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScene> {
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
                  Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(50),
                      child: Container(alignment: Alignment.topCenter, height: 200, width: 200, child: widget.logo),
                    ),
                    Padding(
                        padding: EdgeInsets.all(0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GameScene(Constants.PLUS)),
                            );
                          },
                          child: new Container(
                            child: Center(
                              child: Text(
                                "Play Addition Puzzle",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Constants.TRANSPARENT_WHITE),
                              ),
                            ),
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.all(Radius.circular(15.0))),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GameScene(Constants.MULT)),
                            );
                          },
                          child: new Container(
                            child: Center(
                              child: Text(
                                "Play Multiplication Puzzle",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Constants.TRANSPARENT_WHITE),
                              ),
                            ),
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.all(Radius.circular(15.0))),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(25),
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
                                        child: new Text(Constants.DEVELOPER_INFO),
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
                                        child: new Text(Constants.GAME_INFO),
                                      ),
                                      actions: <Widget>[
                                        new FlatButton(
                                          child: new Text("Open Privacy Policy"),
                                          onPressed: () async {
                                            String url = "https://sahinegilmez.github.io/SiirhanePoems/privacy_policy_math_puzzle.html";
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              print('Could not launch $url');
                                            }
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
