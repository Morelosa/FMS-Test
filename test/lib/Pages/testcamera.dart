

//Idk what this is lol
/*
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

late List<CameraDescription> _cameras;
XFile? _universalFile;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const MaterialApp(home:CameraApp()));
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}



class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  String message = "";


  
  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future getVideoFile(ImageSource sourceImage) async{
    //XFile? videoImage;


    //videoImage= await ImagePicker.pickVideo(source: sourceImage);
    final returnedVideo = await ImagePicker().pickVideo(source: ImageSource.camera);

    if(returnedVideo != null){

      _universalFile = returnedVideo;

      File sentFile = File(_universalFile!.path);
      uploadVideo(sentFile);

      Navigator.push(context, MaterialPageRoute(builder: (context) => const Confirmation() ));

    }


  }

  Future<void> uploadVideo(File file) async {
    try {
      print("Started video upload!");
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.187:8080/process_video'),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          file.path,
          contentType: MediaType('video', 'mp4'),
        ),
      );

      print("Sending now");
      var response = await request.send();
      print("Sent");

      http.Response res = await http.Response.fromStream(response);

      if (res.body != null) {
        final resJson = jsonDecode(res.body);

        if (resJson['result'] is double) {
          // Convert double to string
          message = resJson['result'].toString();
        } else {
          // Use as is
          message = resJson['result'] ?? 'No result received';
        }

        print('Message: $message');
        setState(() {});
      } else {
        print('Empty response body');
      }



    } catch (e) {
      print("Error uploading video: $e");
    }
    

  }

  @override 
  Widget build(BuildContext context){
    if(!controller.value.isInitialized){
      return Container();
    }
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed:() {
            getVideoFile(ImageSource.camera);
            
          },
        child: const Text("Open Camera"),
          
        )
      )

    );

  }


}


class Confirmation extends StatelessWidget{
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        alignment: Alignment.center,
        child: const Column(children: [
          Text("File Uploaded Sucessfully!"),
          
        ],)
      )
    );
    
  }
}
*/















//This is the version with the backend fully integrated!


import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

late List<CameraDescription> _cameras;
XFile? _universalFile;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const MaterialApp(home: CameraApp()));
}

class CameraApp extends StatefulWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  String message = "";

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future getVideoFile(ImageSource sourceImage) async {
    final returnedVideo = await ImagePicker().pickVideo(source: ImageSource.camera);

    if (returnedVideo != null) {
      _universalFile = returnedVideo;
      File sentFile = File(_universalFile!.path);
      uploadVideo(sentFile);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Confirmation()));
    }
  }

  Future<void> uploadVideo(File file) async {

    try {
      print("Started video upload!");
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.187:8080/process_video'),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          file.path,
          contentType: MediaType('video', 'mp4'),
        ),
      );

      print("Sending now");
      var response = await request.send();
      print("Sent");

      http.Response res = await http.Response.fromStream(response);

      if (res.body != null) {
        final resJson = jsonDecode(res.body);
        message = resJson['result'] ?? 'No result received';
        print('Message: $message');
        setState(() {});
      } else {
        print('Empty response body');
      }
      // Delete the video file after processing
      if (file.existsSync()) {
        file.delete();
        print('Video file deleted.');
      } else {
        print('Video file not found.');
      }

    } catch (e) {
      print("Error uploading video: $e");
    }

  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            getVideoFile(ImageSource.camera);
          },
          child: const Text("Open Camera"),
        ),
      ),
    );
  }
}

class Confirmation extends StatelessWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Column(
          children: [
            Text("File Uploaded Successfully!"),
          ],
        ),
      ),
    );
  }
}








/*
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';



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







class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage(
    {Key? key, required this.cameras}) : super(key:key);
  @override
    State<CameraPage> createState() => _CameraPageState();
  }


  class _CameraPageState extends State<CameraPage> {
    late CameraController _cameraController;

    Future initCamera(CameraDescription cameraDescription) async {
  // create a CameraController
    _cameraController = CameraController(
      cameraDescription, ResolutionPreset.high);
  // Next, initialize the controller. This returns a Future.
    try {
      await _cameraController.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
      });
    } on CameraException catch (e) {
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
            child: _cameraController.value.isInitialized
              ? CameraPreview(_cameraController)
              : const Center(child:
              CircularProgressIndicator()
              )
        )
    );
  }






}

*/