import 'package:flutter/material.dart';
import './random_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random(); // create constant variable

    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple[900]),
      home: RandomWords()
        );
  } // Material App
}

