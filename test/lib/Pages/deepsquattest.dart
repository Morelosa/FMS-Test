import 'package:flutter/material.dart';
import 'package:dynamic_widget/dynamic_widget.dart';



class DeepSquat extends StatefulWidget{
  const DeepSquat({super.key});

  @override
  State<DeepSquat> createState() => _DeepSquatState();
  
  
}

class _DeepSquatState extends State<DeepSquat>{

  //List to store dynamic text field widgets
  List<DynamicWidget> listDynamic = [];

  //List to store data
  List<String> data = [];

  //Ion fo floating action button
  Icon floatingIcon = new Icon(Icons.add);

  //function to add dynamic text field widgets to list
  addDynamic(){

    //If data is alredy present, cleaer it before adding more text fields
    if (data.length != 0){
      floatingIcon = new Icon (Icons.add);
      data = [];
      listDynamic = [];
    }

    //Limit number of text fields to 5
    if(listDynamic.length >=5){
      return;
    }

    //Add new dynamic text field widget to list
    listDynamic.add(new DynamicWidget());
    setState(() {});
  }

  //Function to retrieve ndata from text fields and display in a list
  submitData(){
    floatingIcon = new Icon(Icons.arrow_back);
    data = [];
    listDynamic.forEach((widget) => data.add(widget.controller.text));
    setState(() {});
    print(data.length);
  }

  



  int dropdownValue = 0;

  @override
  Widget build(BuildContext context) {

    //Widget to display list of entered data
    Widget result = Flexible(
      flex: 1,
      child: Card(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (_, index){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Text("${index+1} : ${data[index]}}"),
                  ),
                  Divider(),
                ],)
            );
          }
        )
      )

    );

    //Widget to Display dynamic text field widgets
    Widget dynamicTextField = Flexible(
      flex: 2,
      child: ListView.builder(
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],

      )
    );

    //Widget for submitting data
    Widget submitButton =  Container(
      child: ElevatedButton(
        onPressed: submitData,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Submit Data")
        )
      )

    );
    

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

        //Start test button (Will have to make this button dynamically render upon each test completion)
        /*Container(
          
          child: ElevatedButton(
            onPressed: () {
              print("Matthews portion goes here.");
            },

            child: const Text("Start Test"),

          ),
        ),*/

        //New, dynamically self generating start test button, since we must incorperate multiple tests
        /*Column(children: [

          //Child that contains the dynamic portion of the widgit?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
            Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 10, top:5),
            height: 30,
            width: 280,
            color: Colors.blue,
            child: const Text(
              "Hello",
              style: TextStyle(color: Colors.white)
            )

            ),

            GestureDetector(
              child: const Icon(Icons.remove),
              onTap: () {

              
            }

            ),
          ],)
         
        ],),*/

        //Child that contains the create new and delete tests
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          
          children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("Create"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: (){

            }
          ),

          ElevatedButton.icon(
            icon: const Icon(Icons.clear),
            label: const Text("Clear"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: (){
              
            }
          )

        ],),*/




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


//Widet for dnamic text field
class DynamicWidget extends StatelessWidget{
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'Enter Data'),
      )
    );
  }
}