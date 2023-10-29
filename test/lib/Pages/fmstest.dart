import 'package:flutter/material.dart';
import 'package:test/Pages/deepsquattest.dart';


class FMSTest extends StatefulWidget{
  const FMSTest({super.key});

  @override
  State<FMSTest> createState() => _FMSTestState();   
}

class _FMSTestState extends State<FMSTest>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("FMS Test"),

      ),
      body: PageView(children: const [

        DeepSquat(),

        
      ],)


    );
  }

}