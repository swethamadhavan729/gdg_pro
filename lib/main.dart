import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'voter_list_screen.dart';
import 'home_screen.dart'; // Add this line

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voter Verification App',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(),
        '/voterList': (context) => VoterListScreen(),
        '/camera': (context) => CameraScreen(),
      },
    );
  }
}
