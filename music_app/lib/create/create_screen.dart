import 'package:flutter/material.dart';
import 'package:music_app/create/create_controller.dart';
import 'package:music_app/dependency_context.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _titleController = TextEditingController();
  final _stylesController = TextEditingController();
  final _lyricsController = TextEditingController();
  bool _advancedMode = false;
  int _songDuration = 0;
  int _cfgStrength = 0;
  int _steps = 0;

  final List<Map<String, String>> _songs = [
    {'title': 'Song A', 'styles': 'Rock'},
    {'title': 'Song B', 'styles': 'Jazz'},
  ];

  void _toggleFavorite(int index) {
    print('Favorite clicked for ${_songs[index]['title']}');
  }

  void _deleteSong(int index) {
    setState(() => _songs.removeAt(index));
  }

  Future<void> _createSong() async {
    final title = _titleController.text;
    final styles = _stylesController.text;
    final lyrics = _lyricsController.text;
    final songDuration = _songDuration = 95;
    final cfgStrength = _cfgStrength = 6;
    final steps = _steps = 32;

    if (title.isEmpty || styles.isEmpty || lyrics.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    await di.get<CreateController>().createSong(
          title: title,
          styles: styles,
          lyrics: lyrics,
          duration: songDuration,
          cfgStrength: cfgStrength,
          steps: steps,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: _stylesController,
                      decoration: InputDecoration(labelText: 'Styles'),
                    ),
                    TextField(
                      controller: _lyricsController,
                      decoration: InputDecoration(labelText: 'Lyrics'),
                      maxLines: 3,
                    ),
                    SwitchListTile(
                      title: Text('Advanced Mode'),
                      value: _advancedMode,
                      onChanged: (val) => setState(() => _advancedMode = val),
                    ),
                    if (_advancedMode) ...[
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Song Length'),
                        onChanged: (val) => setState(
                            () => _songDuration = int.tryParse(val) ?? 0),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'CFG Strength'),
                        onChanged: (val) => setState(
                            () => _cfgStrength = int.tryParse(val) ?? 0),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Steps'),
                        onChanged: (val) =>
                            setState(() => _steps = int.tryParse(val) ?? 0),
                      ),
                    ],
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _createSong,
                      child: const Text('Create'),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(width: 1),
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
          ],
        ),
      ),
    );
  }
}
