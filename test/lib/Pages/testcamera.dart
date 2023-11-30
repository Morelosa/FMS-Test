import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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

  //********************************************** */

  Future<String> sendFrameToAPI(Uint8List frameBytes) async {
    // Replace 'YOUR_API_ENDPOINT' with the actual endpoint of your Flask API
    final apiUrl = Uri.parse('http://127.0.0.1:8080/process_video');

    try {
      // Send the video frame to the API
      final response = await http.post(
        apiUrl,
        body: frameBytes,
        headers: {'Content-Type': 'application/octet-stream'},
      );

      // Handle the API response
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> responseData = json.decode(response.body);
        final double result = responseData['result'];
        return 'Success: $result';
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error sending frame to API: $e');
      return 'Error: $e';
    }
  }

  void startStreaming() {
    // Periodically capture and send frames
    Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      if (_cameraController.value.isInitialized) {
        // Retrieve a frame from the camera
        final XFile image = await _cameraController.takePicture();

        if (image != null) {
          // Read the image file as bytes
          final File file = File(image.path);
          final Uint8List bytes = await file.readAsBytes();

          // Send the frame to the Flask API
          final apiResponse = await sendFrameToAPI(bytes);

          // Handle the API response
          print(apiResponse);
          // You can update the UI or perform other actions based on the API response
        }
      }
    });
  }
  //*************************************** */

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
  startStreaming();
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
        ),

        //New chatGPT code
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            _cameraController.dispose();
            Navigator.pop(context);
          }
        ),
    );
    

  }
}
 


