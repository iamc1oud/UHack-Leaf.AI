import 'package:flutter/material.dart';
import 'screen/favorite.dart';
import 'screen/mainpage.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

void main() async {
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  runApp(MaterialApp(
    home: App(),
    debugShowCheckedModeBanner: false,
  ));

  await Hive.openBox('gradient');
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

        children: [new Main(buttonText: buttonText), new FavoritePage()],
      ),
    );
  }
}
