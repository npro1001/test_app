import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[]; // Generates List of words
  final _savedWordPairs = Set<WordPair>(); // Set - each obj can only be saved once -Place to store saved wordPairs

Widget _buildList() {
  return ListView.builder(
    padding: const EdgeInsets.all(16.0),
    itemBuilder: (context, item) {
      if(item.isOdd) return Divider();

      final index = item ~/2; // Calculates the number of word pairs that are in the listview - the divider widget

      if(index >= _randomWordPairs.length){ 
        _randomWordPairs.addAll(generateWordPairs().take(10));
      }

      return _buildRow(_randomWordPairs[index]);
    },
  );
}
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair); //checking if contained

    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle
      (fontSize: 18)),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border, // ? - if true || : - else
        color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if(alreadySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      }
    );
  }

void _pushSaved() { //called when button pressed (onPressed)
  Navigator.of(context).push(
    MaterialPageRoute( // PageRoutes - pushing to stack (stack of Routes)
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _savedWordPairs.map((pair) {
          return ListTile(
            title: Text(pair.asPascalCase,
            style: TextStyle(fontSize: 16.0))
            );
        });

        final List<Widget> divided = ListTile.divideTiles(
          context: context,
          tiles: tiles
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('Saved WordPairs')
          ),
          body: ListView(children: divided));
      }));
}

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('WordPair Generator'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: _pushSaved)
        ],
      ), 
    body: _buildList());
  }
}