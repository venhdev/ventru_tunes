import 'package:flutter/material.dart';
import 'package:tunes/presentation/index_screen.dart';

class TunesApp extends StatelessWidget {
  const TunesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tunes',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.light(
      //   useMaterial3: true,
      // ),
      home: const IndexScreen(initTab: 1),
    );
  }
}
