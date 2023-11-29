import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const MaterialApp(home:HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: SafeArea(
        child: Center(
            child: ElevatedButton(
          onPressed: () async {
            await availableCameras().then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
          },
          child: const Text("Take a Picture"),
        )),
      ),
    );
  }
}

class CameraPage extends StatefulWidget{
  final List<CameraDescription>? cameras;
  const CameraPage(
    {Key? key, required this.cameras}): super(key:key);

  @override
  State<CameraPage> createState() => _CaperaPageState();
  
}

class _CaperaPageState extends State<CameraPage>{
  late CameraController _cameraController;

  Future initCamera(CameraDescription cameraDescription) async{
    _cameraController =  CameraController(cameraDescription, ResolutionPreset.high);

    try{
      await _cameraController.initialize().then((_){
        if(!mounted) return;
        setState((){});

      });
    } on CameraException catch (e){
      debugPrint("camera error $e");
    }

  }

  @override
  void initState() {
  super.initState();
  // initialize the rear camera
  initCamera(widget.cameras![0]);
  } 

@override
void dispose() {
  // Dispose of the controller when the widget is disposed.
  _cameraController.dispose();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: _cameraController.value.isInitialized? CameraPreview(_cameraController): const Center(child:CircularProgressIndicator())
        )
    );
    

  }
}
 


