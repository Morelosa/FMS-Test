import 'package:flutter/material.dart';
import 'package:test/Pages/deepsquattest.dart';
import 'package:test/Pages/fmstest.dart';


//State
class CreateTest extends StatefulWidget {
  const CreateTest({super.key});

  @override
  State<CreateTest> createState() => _CreateTestState();
}

class _CreateTestState extends State<CreateTest> {
  
  bool isExerciseSelected(bool exercise1, bool exercise2, bool exercise3, bool exercise4, bool exercise5, bool exercise6, bool exercise7, ){
    bool isSelected = false;

    if(exercise1 || exercise2 || exercise3 || exercise4 || exercise5 || exercise6|| exercise7){
      isSelected = true;
    }

    return isSelected;
  }

  //Keeps trach of the state of each of the exercises being selected
  bool includeSquat = false;
  bool includeHurdle = false;
  bool includeLunge = false;
  bool includeShoulder = false;
  bool includeLegRaise = false;
  bool includePushUp = false;
  bool includeRotary = false;
  bool exercisesSelected = false;


  @override
  Widget build(BuildContext context){
    return Scaffold(

      //Creates the App bar, which tells you create new test
      appBar: AppBar(
        title: const Text("Create New Test"),
      ),

      //Makes each of the available exercises listed
      body: ListView(
        padding: const EdgeInsets.all(10),
        children:  [

        //Deep Squat container
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
              style: BorderStyle.solid
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            

            //Image
            Container(
              alignment: Alignment.centerLeft,
              width: 100,
              height: 100,
              child: Image.asset("assets/Deep Squat.png"),
            ),

            //Text
            Container(
              alignment: Alignment.center,
              child: const Text("Deep Squat",style: TextStyle(fontSize:18, color: Colors.black87),),
            ),

            //Switch
            Container(
              alignment: Alignment.centerRight,
              child:Switch(
                activeColor: Colors.blue.shade100,
                value: includeSquat,
                onChanged: (value){
                  setState(() {
                    includeSquat =!includeSquat;
                  });
                })
            )
            


          ],)

        ),

        //Hurdle Step
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
              style: BorderStyle.solid
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            //Image
            Container(
              alignment: Alignment.centerLeft,
              width: 100,
              height: 100,
              child: Image.asset("assets/Hurdle Step.png"),
            ),

            //Text
            const Text("Hurdle Step", style: TextStyle(fontSize:18, color: Colors.black87),),

            //Switch
            Container(
              alignment: Alignment.centerRight,
              child:Switch(
                activeColor: Colors.blue.shade100,
                value: includeHurdle,
                onChanged: (value){
                  setState(() {
                    includeHurdle =!includeHurdle;
                  });
                })
            )

          ]),
        ),

        //Inline Lunge
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            //Image
            Container(
              alignment: Alignment.centerLeft,
              width: 100,
              height: 100,
              child: Image.asset("assets/Inline Lunge.png"),
            ),

            //Text
            Text("Inline Lunge", style: TextStyle(fontSize:18, color: Colors.black87),),

            //Switch
            Container(
              alignment: Alignment.centerRight,
              child:Switch(
                activeColor: Colors.blue.shade100,
                value: includeLunge,
                onChanged: (value){
                  setState(() {
                    includeLunge =!includeLunge;
                  });
                })
            )

          ])
        ),

        //Shoulder Mobility
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            //Image
            Container(
              alignment: Alignment.centerLeft,
              width: 100,
              height: 100,
              child: Image.asset("assets/Shoulder Mobility.png"),
            ),

            //Text
            const Text("Shoulder Mobility", style: TextStyle(fontSize:18, color: Colors.black87),),

            //Switch
            Container(
              alignment: Alignment.centerRight,
              child:Switch(
                activeColor: Colors.blue.shade100,
                value: includeShoulder,
                onChanged: (value){
                  setState(() {
                    includeShoulder =!includeShoulder;
                  });
                })
            )

            

          ]),
        ),

        //Acitive straight-leg raise
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            //Image
            Container(
              alignment: Alignment.centerLeft,
              width: 100,
              height: 100,
              child: Image.asset("assets/Active Straight-Leg Raise.png"),
            ),

            //Text
            const Text("Leg Raise", style: TextStyle(fontSize:18, color: Colors.black87),),

            //Switch
            Container(
              alignment: Alignment.centerRight,
              child:Switch(
                activeColor: Colors.blue.shade100,
                value: includeLegRaise,
                onChanged: (value){
                  setState(() {
                    includeLegRaise =!includeLegRaise;
                  });
                })
            )


          ])
        ),

        //Trunk stability push up
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
              style: BorderStyle.solid
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            //Image
            Container(
              alignment: Alignment.centerLeft,
              width: 100,
              height: 100,
              child: Image.asset("assets/Trunk Stability Push Up.png"),
            ),

            //Text
            const Text("Push Up", style: TextStyle(fontSize:18, color: Colors.black87),),

            //Switch
            Container(
              alignment: Alignment.centerRight,
              child:Switch(
                activeColor: Colors.blue.shade100,
                value: includePushUp,
                onChanged: (value){
                  setState(() {
                    includePushUp =!includePushUp;
                  });
                })
            )

          ]),
        ),

        //rotary stability
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
              style: BorderStyle.solid
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            //Image
            Container(
              alignment: Alignment.centerLeft,
              width: 100,
              height: 100,
              child: Image.asset("assets/Rotary Stability.jpg"),
            ),

            //Text
            const Text("Rotary Stablility", style: TextStyle(fontSize:18, color: Colors.black87),),

            //Switch
            Container(
              alignment: Alignment.centerRight,
              child:Switch(
                activeColor: Colors.blue.shade100,
                value: includeRotary,
                onChanged: (value){
                  setState(() {
                    includeRotary =!includeRotary;
                  });
                })
            )

          ])
        ),

        /*Text("Deep Squat $includeSquat"),
        Text("Hurdle Step $includeHurdle"),
        Text("Inline Lunge $includeLunge"),
        Text("Shoulder Mobility $includeShoulder"),
        Text("Leg Raise $includeLegRaise"),
        Text("Push Up $includePushUp"),
        Text("Rotary Stability $includeRotary"),*/

        ElevatedButton(
          
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => FMSTest()));
          },
          
          child: Text("Build new Test"),
          )
        
      ],)

    );
  }
 
  




}



