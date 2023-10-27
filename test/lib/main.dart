import 'package:flutter/material.dart';
import 'Pages/createnewtest.dart';


void main() => runApp(Transition());


//New guide that showed how to make a navagation tree
class Transition extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return MaterialApp(

      //theme:darkTheme,
    
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
        title: Text("FMS Test"),
      ),

      body: Center(
        
        child: ElevatedButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewTest() ));
        },
        child: Text("Create New Test"),
        ),
        
      )


    );
  }
}

//Refrence a pre created page called page two. Functionally useless, but used as a refrence
class Page2 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Page 2"),
      ),
      body: Center(
        child: ElevatedButton(
        onPressed: (){
          Navigator.pop(context);

        },
        child: Text("Move to Page 1"),
        ),

      )


    );
  }
}



ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark
);