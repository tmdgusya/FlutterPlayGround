import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords()
    );
  }
}

class _RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFront = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Generate!!'),
        actions: [
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
        ],
      ),body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
          // NEW lines from here...
          builder: (BuildContext context) {
            final tiles = _saved.map(
                  (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFront,
                  ),
                );
              },
            );
            final divided = ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList();

            return Scaffold(
              appBar: AppBar(
                title: Text('Saved Suggestions'),
              ),
              body: ListView(children: divided),
            );
          }, //
        ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final alreadySaved = _saved.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFront,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }

}

class RandomWords extends StatefulWidget {

    @override
    _RandomWordsState createState() => _RandomWordsState();
  
}

