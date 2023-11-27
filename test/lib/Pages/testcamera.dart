import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


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


      //Navigator.push(context, MaterialPageRoute(builder: (context) => Confirmation() ));

    }


  }

  Future<void> uploadVideo(File file) async{
    if(file == null){
      return;
    }

    try{
      print("Started video upload!");
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.187:8080/process_video')
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          file.path,
          contentType: MediaType('video','mp4'),
        )
      );

      print("Sending now");
      var response = await request.send();
      print("Sent");

      //Random youtuber told me to put this part down
      http.Response res = await http.Response.fromStream(response);
      final resJson = jsonDecode(res.body);
      message = resJson['message'];
      setState(() {});

      if(response.statusCode == 200){
        print("Video uploaded sucessfully!");
      }
      else{
        print("Failed to upload video. Status Code: ${response.statusCode}");
      }
      
    }
    catch(e){
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
        child: Text("Open Camera"),
          
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
        child: Column(children: [
          const Text("File Uploaded Sucessfully!"),

          Container(
            child: Image.file(File(_universalFile!.path)),
          )
          
        ],)
      )
    );
    
  }
}


/*class Camera extends StatefulWidget{
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();

}

class _CameraState extends State<Camera>{

}*/

/*
Future<CameraController> initializeCamera() async {
  final cameras = await availableCameras();
  final camera = cameras.first;

  return CameraController(
    camera,
    ResolutionPreset.medium,
  );
}

class VideoRecordingScreen extends StatefulWidget {
  @override
  _VideoRecordingScreenState createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  late CameraController _cameraController;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    initializeCamera().then((controller) {
      setState(() {
        _cameraController = controller;
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _startStopRecording() async {
    if (isRecording) {
      await _cameraController.stopVideoRecording();
    } else {
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/Videos/';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${DateTime.now().millisecondsSinceEpoch}.mp4';
      await _cameraController.startVideoRecording();
    }

    setState(() {
      isRecording = !isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Video Recording'),
      ),
      body: AspectRatio(
        aspectRatio: _cameraController.value.aspectRatio,
        child: CameraPreview(_cameraController),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startStopRecording,
        child: Icon(isRecording ? Icons.stop : Icons.fiber_manual_record),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
*/