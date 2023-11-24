import 'package:flutter/material.dart';
import 'package:test/Pages/deepsquattest.dart';
import 'package:test/Pages/hurdlesteptest.dart';
import 'package:test/Pages/inlinelungetest.dart';
import 'package:test/Pages/legraisetest.dart';
import 'package:test/Pages/pushuptest.dart';
import 'package:test/Pages/rotartystability.dart';
import 'package:test/Pages/shouldermobility.dart';


class FMSTest extends StatefulWidget{
  const FMSTest({super.key});


  @override
  State<FMSTest> createState() => _FMSTestState();   
}

class _FMSTestState extends State<FMSTest>{
  final PageController _pageController = PageController(initialPage: 0);

  final int _activePage = 0;







  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preform Test"),

      ),
      body: PageView(children: const [

        DeepSquat(),
        //HurdleStep(),
        //InlineLunge(),
        //ShoulderMobility(),
        //LegRaise(),
        //PushUp(),
        //RotaryStability()
        

        
      ],)


    );
  }

}