import 'package:flutter/material.dart';


/*The seven tests are:
  deep squat
  Hurdle Step'
  inline Lunge
  Shoulder Mobility
  Acitive straight-leg raise
  Trunk stability push up
  rotary stability*/ 
class CreateNewTest extends StatelessWidget{
  bool includeSquat = false;
  bool includeHurdle = false;
  bool includeLunge = false;
  bool includeShoulder = false;
  bool includeLegRaise = false;
  bool includePushUp = false;
  bool includeRotary = false;

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
            color: Colors.blue.shade100,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))

          ),
          child: Row(children: [
            //Image
            Container(
              alignment: Alignment.centerLeft,
              width: 160,
              height: 100,
              child: Image.asset("assets/racist.png"),
            ),

            //Text
            Text("Deep Squat",style: TextStyle(fontSize:20, color: Colors.black87),),

            //Switch
            


          ],)

        ),

        //Hurdle Step
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.red.shade700,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))

          ),
          child: Row(children: [
            Text("Hurdle Squat", style: TextStyle(fontSize:20, color: Colors.black87),),
          ]),
        ),

        //Inline Lunge
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))

          ),
          child: Row(children: [
            Text("Inline Lunge", style: TextStyle(fontSize:20, color: Colors.black87),),
          ])
        ),

        //Shoulder Mobility
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.red.shade700,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))

          ),
          child: Row(children: [
            Text("Shoulder Mobility", style: TextStyle(fontSize:20, color: Colors.black87),),
          ]),
        ),

        //Acitive straight-leg raise
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))

          ),
          child: Row(children: [
            Text("Active Straight-leg raise", style: TextStyle(fontSize:20, color: Colors.black87),),
          ])
        ),

        //Trunk stability push up
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.red.shade700,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))

          ),
          child: Row(children: [
            Text("Push Up", style: TextStyle(fontSize:20, color: Colors.black87),),
          ]),
        ),

        //rotary stability
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.0),
          
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))

          ),
          child: Row(children: [
            Text("Rotary Stablility", style: TextStyle(fontSize:20, color: Colors.black87),),
          ])
        ),


        
      ],)

    );
  }
 
}






//Switches
class SquatSwitch extends StatefulWidget {
  const SquatSwitch({super.key});

  @override
  State<SquatSwitch> createState() => _SquatSwitchState();
}

class _SquatSwitchState extends State<SquatSwitch> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.red,
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}



