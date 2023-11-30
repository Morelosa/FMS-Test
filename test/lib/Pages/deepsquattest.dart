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
class DeepSquat extends StatefulWidget{
  const DeepSquat({super.key});

  @override
  State<DeepSquat> createState() => _DeepSquatState();
  
  
}

late List<CameraDescription> _cameras;
XFile? _universalFile;

class _DeepSquatState extends State<DeepSquat> {

  int dropdownValue = 0;
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
    //Widget to display list of entered data
    
    return Scaffold(
      //Page Styling
      backgroundColor: Colors.blue.shade100,

      //Main body
      body: Column(children: [

        //Title Text Container
        Container(
          alignment: Alignment.center,
          child: const Text("Deep Squat", style: TextStyle(fontSize: 32,),),
        ),

        //Image of the exercise
        Container(
          alignment: Alignment.center,
          child: Image.asset("assets/Deep Squat.png"),
        ),

        //Starting exercise goes here
        ElevatedButton(
          onPressed: () async{
            getVideoFile(ImageSource.camera);
          },
          child: const Text("Start Test"),
        ),
        



        //Rate pain of exercise switch
        Container(
          alignment: Alignment.center,
          child:Column(children:[ 

            const Text("Pain Scale"),
            
            DropdownButton<int>(
            value: dropdownValue,
            icon: const Icon(Icons.menu),
            style:const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black
            ),

            onChanged: (int? newValue){
              setState(() {
                dropdownValue = newValue!;
              });
            },

            items: const [
              DropdownMenuItem<int>(
                value: 0,
                child: Text("0"),
              ),

              DropdownMenuItem<int>(
                value: 1,
                child: Text("1"),
              ),

              DropdownMenuItem<int>(
                value: 2,
                child: Text("2"),
              ),

              DropdownMenuItem<int>(
                value: 3,
                child: Text("3"),
              ),

              DropdownMenuItem<int>(
                value: 4,
                child: Text("4"),
              ),

              DropdownMenuItem<int>(
                value: 5,
                child: Text("5"),
              ),

              DropdownMenuItem<int>(
                value: 6,
                child: Text("6"),
              ),

              DropdownMenuItem<int>(
                value: 7,
                child: Text("7"),
              ),

              DropdownMenuItem<int>(
                value: 8,
                child: Text("8"),
              ),

              DropdownMenuItem<int>(
                value: 4,
                child: Text("9"),
              ),


                
            ]


          )
        ])
        ),

        //About exercise
        Container(
          child:ElevatedButton(
            child: Text("How to preform the Deep Squat"),
            onPressed: (){
              print("Work in progress. Please bare with me.");
            }
          ),
        ),






      ],)




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
