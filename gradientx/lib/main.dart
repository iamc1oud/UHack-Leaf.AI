import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradientx/models/card.dart';
import 'screen/favorite.dart';
import 'screen/mainpage.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

void main() async {

  // Get the application location on device
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();

  // Initializing the Hive and then open the box which return Future
  Hive.init(appDocumentDirectory.path);

  runApp(MaterialApp(
    home: App(),
    debugShowCheckedModeBanner: false,
  ));
  Hive.registerAdapter(GradientCardAdapter(), 0);

}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  TextStyle buttonText = TextStyle(fontSize: 20, fontFamily: 'Arvo', color: Colors.white);
  PageController pageController = new PageController(initialPage: 0, keepPage: false, viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TabBarView(
        //controller: pageController,
        controller: TabController(initialIndex: 0, length: 2, vsync: this),

        children: [new Main(buttonText: buttonText), FutureBuilder(
          future: Hive.openBox('gradient'),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              return FavoritePage();
            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              return CupertinoActivityIndicator();
            }
            return Scaffold();
          },
        )],
      ),
    );
  }
}
