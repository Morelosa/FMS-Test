import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class DeepSquat extends StatefulWidget{
  const DeepSquat({super.key});

  @override
  State<DeepSquat> createState() => _DeepSquatState();
  
  
}

class _DeepSquatState extends State<DeepSquat>{

  int dropdownValue = 0;

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


