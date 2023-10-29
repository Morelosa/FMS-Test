import 'package:flutter/material.dart';

class ShoulderMobility extends StatefulWidget{
  const ShoulderMobility({super.key});

  
  @override
  State<ShoulderMobility> createState() => _ShoulderMobility();

}

class _ShoulderMobility extends State<ShoulderMobility>{
  int dropdownValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Page Styling
      backgroundColor: Colors.blue.shade100,

      //Main body
      body: Column(children: [

        //Title Text Container
        Container(
          alignment: Alignment.center,
          child: const Text("Shoulder Mobility", style: TextStyle(fontSize: 32,),),
        ),

        //Image of the exercise
        Container(
          alignment: Alignment.center,
          child: Image.asset("assets/Shoulder Mobility.png"),
        ),

        //Start test button (Will have to make this button dynamically render upon each test completion)
        Container(
          
          child: ElevatedButton(
            onPressed: () {
              print("Matthews portion goes here.");
            },

            child: const Text("Start Test"),

          ),
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
                value: 9,
                child: Text("9"),
              ),


                
            ]


          )
        ])
        ),

        //About exercise
        Container(
          child:ElevatedButton(
            child: const Text("How to preform the Shoulder Mobility Exercise"),
            onPressed: (){
              print("Work in progress. Please bare with me.");
            }
          ),
        ),






      ],)




    ); 


  }


}