import 'package:flutter/material.dart';


// TEST CODE FILES
import 'test_code/issueraisedscreen.dart';
import 'test_code/compliantscreen.dart';
import 'test_code/numberoftenantscreen.dart';
import 'test_code/previousdampandmouldscreen.dart';
import 'test_code/movefurniturewithoutassistancescreen.dart';
import 'test_code/residentsabove50screen.dart';
import 'test_code/respiratoryissuesorchildrenu14screen.dart';
import 'test_code/residentswithpregnancyscreen.dart';
import 'test_code/disabilityorbedboundscreen.dart';
import 'test_code/healthconditionorimmunesystemscreen.dart';
import 'test_code/mentalhealthscreen.dart';
import 'test_code/roomsinpropertyscreen.dart';
import 'test_code/arealargerthandoorscreen.dart';
import 'test_code/residentswithheatingscreen.dart';
import 'test_code/waterleakscreen.dart';
import 'test_code/mouldlocationscreen.dart';
import 'test_code/waterleakdescriptionscreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ComplaintScreen(),
    );
  }
}