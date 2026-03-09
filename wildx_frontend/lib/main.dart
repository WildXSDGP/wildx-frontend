import 'package:flutter/material.dart';
import './screens/park_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WildX',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const ParkSearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
