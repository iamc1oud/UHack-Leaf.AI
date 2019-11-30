import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({
    Key key,
  }) : super(key: key);

  // Shared preferences in app to store info within app

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.pink[700]], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
        ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.pink, Colors.red]),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(10, 20, 20, 0.1),
                          spreadRadius: 0.2,
                          blurRadius: 5,
                          offset: Offset(5, 10))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.pink, Colors.red]),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(10, 20, 20, 0.1),
                          spreadRadius: 0.2,
                          blurRadius: 5,
                          offset: Offset(5, 10))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.pink, Colors.red]),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(10, 20, 20, 0.1),
                          spreadRadius: 0.2,
                          blurRadius: 5,
                          offset: Offset(5, 10))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.pink, Colors.red]),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(10, 20, 20, 0.1),
                          spreadRadius: 0.2,
                          blurRadius: 5,
                          offset: Offset(5, 10))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
