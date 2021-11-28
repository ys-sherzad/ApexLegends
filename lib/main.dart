import 'package:flutter/material.dart';
import 'package:apex/src/apex.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Titillium Web',
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Apex(),
      ),
    );
  }
}
