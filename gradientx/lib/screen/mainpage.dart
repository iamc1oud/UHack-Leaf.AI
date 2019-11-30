import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:gradientx/models/card.dart';
import 'package:hive/hive.dart';

class Main extends StatefulWidget {
  Main({
    Key key,
    @required this.buttonText,
  }) : super(key: key);

  final TextStyle buttonText;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with AutomaticKeepAliveClientMixin<Main> {
  bool firstPicker = false;
  bool secondPicker = false;

  // color values
  // For first picker
  double redFirst = 155;
  double greenFirst = 55;
  double blueFirst = 255;

  // For second picker
  double redSecond = 175;
  double greenSecond = 55;
  double blueSecond = 255;

  // Add new gradient to database
  void addGradient(GradientCard gradient) async {
    var box = await Hive.openBox('gradient');
    box.add(gradient);
    gradient.save();
    print("Hive put new gradient");
  }

  Widget FirstPicker() {
    return new Column(
      children: <Widget>[
        new SizedBox(
          height: 50,
          child: Chip(
              label: new Text(
            "Primary Color",
          )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: FluidSlider(
            value: redFirst,
            onChanged: (double newValue) {
              setState(() {
                redFirst = newValue;
              });
            },
            min: 0,
            max: 255,
            sliderColor: Colors.red,
            thumbColor: Colors.white60,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: FluidSlider(
            value: greenFirst,
            onChanged: (double newValue) {
              setState(() {
                greenFirst = newValue;
              });
            },
            min: 0,
            max: 255,
            sliderColor: Colors.green,
            thumbColor: Colors.white60,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: FluidSlider(
            value: blueFirst,
            onChanged: (double newValue) {
              setState(() {
                blueFirst = newValue;
              });
            },
            min: 0,
            max: 255,
            sliderColor: Colors.blue,
            thumbColor: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget SecondPicker() {
    return new Column(
      children: <Widget>[
        new SizedBox(
          height: 50,
          child: Chip(
              label: new Text(
            "Secondary Color",
          )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: FluidSlider(
            value: redSecond,
            onChanged: (double newValue) {
              setState(() {
                redSecond = newValue;
              });
            },
            min: 0,
            max: 255,
            sliderColor: Colors.red,
            thumbColor: Colors.white60,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: FluidSlider(
            value: greenSecond,
            onChanged: (double newValue) {
              setState(() {
                greenSecond = newValue;
              });
            },
            min: 0,
            max: 255,
            sliderColor: Colors.green,
            thumbColor: Colors.white60,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: FluidSlider(
            value: blueSecond,
            onChanged: (double newValue) {
              setState(() {
                blueSecond = newValue;
              });
            },
            min: 0,
            max: 255,
            sliderColor: Colors.blue,
            thumbColor: Colors.white60,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: new Text("UI Gradient", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: <Widget>[
          new Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF9b37ff), Color(0xFF6419ff)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          ListView(
            physics: BouncingScrollPhysics(),
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            firstPicker = true;
                            secondPicker = false;
                          });
                        },
                        child: new CircleAvatar(
                          minRadius: 20,
                          maxRadius: 30,
                          backgroundColor: Color.fromRGBO(redFirst.toInt(), greenFirst.toInt(), blueFirst.toInt(), 1),
                        ),
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), spreadRadius: 2, blurRadius: 25)]),
                    ),
                    new SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    new Text(
                      "#" +
                          Color.fromRGBO(redFirst.toInt(), greenFirst.toInt(), blueFirst.toInt(), 1)
                              .value
                              .toRadixString(16)
                              .toString(),
                      style: widget.buttonText,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  children: <Widget>[
                    new Container(
                      height: 200,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                            Color.fromRGBO(redFirst.toInt(), greenFirst.toInt(), blueFirst.toInt(), 1),
                            Color.fromRGBO(redSecond.toInt(), greenSecond.toInt(), blueSecond.toInt(), 1)
                          ]),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 0.1,
                                blurRadius: 30,
                                offset: Offset(5, 10))
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        GradientCard gradient =
                            new GradientCard([redFirst, greenFirst, blueFirst], [redSecond, greenSecond, blueSecond]);
                        addGradient(gradient);
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.SUCCES,
                          body: Center(
                            child: Text(
                              'Added to favorites 😍',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          btnOkOnPress: () {},
                        ).show();
                      },
                      splashColor: Colors.orange,
                      child: new Container(
                        height: 50,
                        width: 100,
                        child: Center(
                            child: new Text(
                          "SAVE",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF9b37ff), Color(0xFF6419ff)]),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 0.1,
                                  blurRadius: 30,
                                  offset: Offset(5, 10))
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Text(
                      //"RGB(12,14,14)",
                      "#" +
                          Color.fromRGBO(redSecond.toInt(), greenSecond.toInt(), blueSecond.toInt(), 1)
                              .value
                              .toRadixString(16)
                              .toString(),
                      style: widget.buttonText,
                    ),
                    new SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            secondPicker = true;
                            firstPicker = false;
                          });
                        },
                        child: new CircleAvatar(
                          minRadius: 20,
                          maxRadius: 30,
                          backgroundColor:
                              Color.fromRGBO(redSecond.toInt(), greenSecond.toInt(), blueSecond.toInt(), 1),
                        ),
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), spreadRadius: 4, blurRadius: 25)]),
                    ),
                  ],
                ),
              ),
              Visibility(visible: firstPicker, child: FirstPicker()),
              Visibility(visible: secondPicker, child: SecondPicker()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
