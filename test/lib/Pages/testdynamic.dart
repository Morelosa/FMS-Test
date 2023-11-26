import 'package:flutter/material.dart'; 

void main() => runApp(new MyApp()); 

class MyApp extends StatefulWidget { 
@override 
_MyAppState createState() => _MyAppState(); 
} 






class _MyAppState extends State<MyApp> { 
	
// list to store dynamic text field widgets 
List<DynamicWidget> listDynamic = []; 
	
// list to store data 
// entered in text fields 
List<String> data = []; 

// icon for floating action button 
Icon floatingIcon = new Icon(Icons.add); 

// function to add dynamic 
// text field widget to list 
addDynamic() { 
	// if data is already present, clear 
	// it before adding more text fields 
	if (data.length != 0) { 
	floatingIcon = new Icon(Icons.add); 
	data = []; 
	listDynamic = []; 
	} 
	
	// limit number of text fields to 5 
	if (listDynamic.length >= 5) { 
	return; 
	} 
	
	// add new dynamic text field widget to list 
	listDynamic.add(new DynamicWidget()); 
	setState(() {}); 
} 

// function to retrieve data from 
// text fields and display in a list 
submitData() { 
	// change icon to back arrow and clear existing data 
	floatingIcon = new Icon(Icons.arrow_back); 
	data = []; 
	
	// retrieve data from each text field widget and add to data list 
	listDynamic.forEach((widget) => data.add(widget.controller.text)); 
	
	setState(() {}); 
	print(data.length); 
} 

@override 
Widget build(BuildContext context) { 
	// widget to display list of entered data 
	Widget result = Flexible( 
		flex: 1, 
		child: Card( 
		child: ListView.builder( 
			itemCount: data.length, 
			itemBuilder: (_, index) { 
			return Padding( 
				padding: new EdgeInsets.all(10.0), 
				child: Column( 
				crossAxisAlignment: CrossAxisAlignment.start, 
				children: <Widget>[ 
					Container( 
					margin: new EdgeInsets.only(left: 10.0), 
					child: Text("${index + 1} : ${data[index]}"), 
					), 
					new Divider() 
				], 
				), 
			); 
			}, 
		), 
		)); 

	// widget to display dynamic text field widgets 
	Widget dynamicTextField = Flexible( 
	flex: 2, 
	child: ListView.builder( 
		itemCount: listDynamic.length, 
		itemBuilder: (_, index) => listDynamic[index], 
	), 
	); 

	// widget for submitting data 
	Widget submitButton = Container( 
	child: ElevatedButton( 
		onPressed: submitData, 
		child: const Padding( 
		padding: EdgeInsets.all(16.0), 
		child: Text('Submit Data'), 
		), 
	), 
	); 

	return MaterialApp( 
	home: Scaffold( 
		appBar: AppBar( 
		title: const Text('Dynamic App'), 
		), 
		body: Container( 
		margin: const EdgeInsets.all(10.0), 
		child: Column( 
			children: <Widget>[ 
			// if data is present, display result widget, else display dynamic text field widget 
			data.length == 0 ? dynamicTextField : result, 
			// if data is present, display submit button 
			data.length == 0 ? submitButton : Container(), 
			], 
		), 
		), 
		// floating action button to add dynamic text field widgets 
		floatingActionButton: FloatingActionButton( 
		onPressed: addDynamic, 
		child: floatingIcon, 
		), 
	), 
	); 
} 
} 

// widget for dynamic text field 
class DynamicWidget extends StatelessWidget { 
TextEditingController controller = TextEditingController(); 

@override 
Widget build(BuildContext context){ 
	return Container( 
	margin: EdgeInsets.all(8.0), 
	child: TextField( 
		controller: controller, 
		decoration: InputDecoration(hintText: 'Enter Data '), 
	), 
	); 
} 
}

class DynamicButtons extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: (){
          print("This is working fine brother");
        },
        child: Text("Start new test"),

      )
    );
  }}


//This is my crack at creating a dynamic list of buttons that return a number
