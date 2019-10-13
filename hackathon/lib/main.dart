import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  // Obtain a list of the available cameras on the device.

  cameras = await availableCameras();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'leaf.ai',
      theme: ThemeData(
        primarySwatch: Colors.green ,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Transform.scale(
              scale: 1,
              child: new Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images.png'), fit: BoxFit.fill)
                ),
              ),
            ),
            new SizedBox(height: 30,),
            new Text("leaf.ai", style: TextStyle(fontFamily: "Schyler", fontSize: 30),),
            new SizedBox(height: 50,),
            new TextFormField(
              controller: _username,
              decoration: InputDecoration(
                labelText: "Username",
                  border: OutlineInputBorder()
              ),
            ),
            new SizedBox(height: 10,),
            new TextFormField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder()
              ),
            ),
            new SizedBox(
              height: 20,
            ),
            new RaisedButton(onPressed: () {
              if(_username.text == "cloudmax" && _password.text == "root") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TakePictureScreen()));
              }
            },
              child: new Text("Login"), elevation: 4,colorBrightness: Brightness.dark, color: Colors.green,)
          ],
        ),
      ),
    );

  }
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return LinearProgressIndicator();
    }
    return Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: CameraPreview(controller),
          ),
          Align(
            alignment: Alignment.bottomLeft,

              child: new RaisedButton(onPressed: () async{
                try {
                  // Ensure that the camera is initialized.

                  // Construct the path where the image should be saved using the
                  // pattern package.
                  final path = join(
                    // Store the picture in the temp directory.
                    // Find the temp directory using the `path_provider` plugin.
                    (await getTemporaryDirectory()).path,
                    '${DateTime.now()}.png',
                  );

                  // Attempt to take a picture and log where it's been saved.
                  await controller.takePicture(path);

                  // If the picture was taken, display it on a new screen.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(imagePath: path),
                    ),
                  );
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              }, child: new Text("Click a picture"),)),
          Align(
              alignment: Alignment.bottomRight,
              child: new RaisedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LeafDetail()));
              }, child: new Text("Upload picture"),))
        ],);
  }
}

class LeafDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text("Prediction"),),
      body: Column(

        children: <Widget>[
          new SizedBox(height: 100,),
          new Container(
            height: 200,
            child: new Image(image: AssetImage('assets/leaf.jpg'),),
            color: Colors.green,
          ),
          new SizedBox(height: 50,),
          new Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            //color: Colors.lightGreenAccent,
            child: Center(child: new Text("Prediction", style: TextStyle(color: Colors.deepOrange, fontSize: 40),)),
          ),
          new SizedBox(height: 5,),
          new Chip(label: new Text("Tomato__healthy", style: TextStyle(fontSize: 20, color: Colors.white),), padding: EdgeInsets.all(20),backgroundColor: Colors.green, elevation: 10,)


              ],
            ),
          );
  }
}


// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  File _image;

  Future<void> getImage() async{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      _image = image;
  }

  void getBase64Image(File image) async{
    List<int> imageBytes =  image.readAsBytesSync();

    String base64Image = base64Encode(imageBytes);
    //print(base64Image);
    var url = "http://127.0.0.1:8000/predict";
    print("Requesting response");
    /*var response = await http.post(url, body: {"plant_image" : "data:image/jpeg;base64," + base64Image},headers:  {
      'User-Agent': "PostmanRuntime/7.18.0",
      'Cache-Control': "no-cache",
      'Host': "127.0.0.1:8000",
      'Accept-Encoding': "gzip, deflate",
      'Connection': "keep-alive",
    });*/

    var body = jsonEncode({ "plant_image" :  "data:image/jpeg;base64,"+base64Image });
    print(body);




       // print("Body: " + body);

        var response = await http.post(url,
            headers: {"Content-Type": "application/json"},
            body: body,
          encoding: Encoding.getByName(utf8.toString())
        );

        print(response.body);


    /*Dio dio = new Dio();
    Response response;
    response = await dio.post(url, data: {"plant_image" : "data:image/jpeg;base64," + base64Image});
    print(response.data)*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture'), actions: <Widget>[
        InkWell(
          onTap: () async{
              await getImage();
              getBase64Image(_image);
          },
            child: new Icon(Icons.image))
      ],),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(widget.imagePath)),
      floatingActionButton: new FloatingActionButton(onPressed: () {
        getBase64Image(File(widget.imagePath));
      }, child: Icon(Icons.cloud_upload),),
    );
  }
}