import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:hive/hive.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({
    Key key,
  }) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Box box;
  Iterator it;

  @override
  void initState() {
    gradientBoxOpen();
    super.initState();
  }

  @override
  void dispose() {
    Hive.box('gradient').close();
    super.dispose();
  }

  Future gradientBoxOpen() async {
    box = await Hive.openBox('gradient');
    return "SuccesFul";
  }

  _buildGradientCollection(Map m) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: m.length,
      itemBuilder: (BuildContext ctx, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {
                setState(() {
                  AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          customHeader: new Container(
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(color: Colors.black, blurRadius: 50, spreadRadius: 0.01)],
                                shape: BoxShape.circle,
                                border: Border.all(width: 0, color: Colors.transparent),
                                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                  Color.fromRGBO(
                                      m.values.toList().reversed.elementAt(index).primaryColor[0].toInt(),
                                      m.values.toList().reversed.elementAt(index).primaryColor[1].toInt(),
                                      m.values.toList().reversed.elementAt(index).primaryColor[2].toInt(),
                                      1),
                                  Color.fromRGBO(
                                      m.values.toList().reversed.elementAt(index).secondaryColor[0].toInt(),
                                      m.values.toList().reversed.elementAt(index).secondaryColor[1].toInt(),
                                      m.values.toList().reversed.elementAt(index).secondaryColor[2].toInt(),
                                      1)
                                ])),
                          ),
                          body: Center(
                            child: Column(
                              children: <Widget>[
                                Text('Primary Color', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(Color.fromRGBO(
                                        m.values.toList().reversed.elementAt(index).primaryColor[0].toInt(),
                                        m.values.toList().reversed.elementAt(index).primaryColor[1].toInt(),
                                        m.values.toList().reversed.elementAt(index).primaryColor[2].toInt(),
                                        1)
                                    .value
                                    .toRadixString(16)),
                                Text('Secondary Color', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(Color.fromRGBO(
                                        m.values.toList().reversed.elementAt(index).secondaryColor[0].toInt(),
                                        m.values.toList().reversed.elementAt(index).secondaryColor[1].toInt(),
                                        m.values.toList().reversed.elementAt(index).secondaryColor[2].toInt(),
                                        1)
                                    .value
                                    .toRadixString(16))
                              ],
                            ),
                          ),
                          btnCancelOnPress: () {
                            box.delete(m.keys.toList().reversed.elementAt(index));
                          },
                          btnCancelText: "Delete")
                      .show();
                });

                setState(() {});
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                        Color.fromRGBO(
                            m.values.toList().reversed.elementAt(index).primaryColor[0].toInt(),
                            m.values.toList().reversed.elementAt(index).primaryColor[1].toInt(),
                            m.values.toList().reversed.elementAt(index).primaryColor[2].toInt(),
                            1),
                        Color.fromRGBO(
                            m.values.toList().reversed.elementAt(index).secondaryColor[0].toInt(),
                            m.values.toList().reversed.elementAt(index).secondaryColor[1].toInt(),
                            m.values.toList().reversed.elementAt(index).secondaryColor[2].toInt(),
                            1)
                      ]))),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: new Text("Favorite", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurple,
        ),
        body: Stack(children: <Widget>[
          new Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF9b37ff), Color(0xFF6419ff)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          FutureBuilder(
            future: gradientBoxOpen(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return Center(child: CupertinoActivityIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                Map<dynamic, dynamic> val = box.toMap();
                return _buildGradientCollection(val);
              }
              return Container();
            },
          )
        ]));
  }
}
