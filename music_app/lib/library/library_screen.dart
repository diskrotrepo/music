import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final List<Map<String, String>> _songs = [
    {'title': 'Song A', 'styles': 'Rock', 'lyrics': 'Lyrics for Song A...'},
    {'title': 'Song B', 'styles': 'Jazz', 'lyrics': 'Lyrics for Song B...'},
  ];

  int? _selectedIndex;

  void _toggleFavorite(int index) {
    print('Favorite clicked for ${_songs[index]['title']}');
  }

  void _deleteSong(int index) {
    setState(() {
      _songs.removeAt(index);
      if (_selectedIndex == index) {
        _selectedIndex = null;
      } else if (_selectedIndex != null && _selectedIndex! > index) {
        _selectedIndex = _selectedIndex! - 1;
      }
    });
  }

  void _selectSong(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final selectedLyrics = _selectedIndex != null
        ? _songs[_selectedIndex!]['lyrics']
        : 'Select a song to view lyrics';

    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      body: Row(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _songs.length,
              itemBuilder: (context, index) {
                final song = _songs[index];
                return Card(
                  child: ListTile(
                    title: Text(song['title'] ?? ''),
                    subtitle: Text('Styles: ${song['styles']}'),
                    onTap: () => _selectSong(index),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () => _toggleFavorite(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteSong(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.topLeft,
              child: Text(
                selectedLyrics ?? '',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
