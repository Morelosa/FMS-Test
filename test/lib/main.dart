import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:test/Pages/testdynamic.dart';
import 'Pages/createnewtest.dart';

List<CameraDescription> ? cameras; 

//void main() => runApp(Transition());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(Transition());
}



//New guide that showed how to make a navagation tree
class Transition extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return MaterialApp(

      home: Home(),
    );
  }
}

//Home page
class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(

      
      appBar: AppBar(
        centerTitle: false,
        title: const Text("FMS Test"),
      ),

      body: Center(
        
        child: ElevatedButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CreateTest() ));
        },
        child: const Text("Create New Test"),
        ),
        
      )


    );
  }
}

