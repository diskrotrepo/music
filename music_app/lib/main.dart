import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/create/create_screen.dart';
import 'package:music_app/dependency_context.dart';
import 'package:music_app/home/home_screen.dart';
import 'package:music_app/library/library_screen.dart';
import 'package:music_app/network/network_screen.dart';
import 'package:music_app/settings/settings_screen.dart';
import 'package:music_app/workers/diskrot_background_worker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  await Isolate.spawn(diskRotBackgroundWorker, 4);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'diskrot Demo',
      theme: ThemeData.dark(),
      home: const DiskrotApp(),
    );
  }
}

class DiskrotApp extends StatefulWidget {
  const DiskrotApp({super.key});

  @override
  State<DiskrotApp> createState() => _DiskrotHomeState();
}

class _DiskrotHomeState extends State<DiskrotApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 1024),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      color: const Color.fromARGB(137, 57, 57, 57),
                      child: _buildNavigationMenu(),
                    ),
                    Expanded(
                      child: _buildContent(),
                    ),
                  ],
                ),
              ),
              _MusicPlayerBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationMenu() {
    return ListTileTheme(
      textColor: Colors.white,
      iconColor: Colors.white,
      selectedColor: Colors.white,
      selectedTileColor: Colors.pink,
      child: ListView(
        children: [
          ListTile(
            title: const Text('diskrot'),
            tileColor: const Color.fromARGB(255, 221, 1, 1),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.house),
            title: const Text('Home'),
            selected: _selectedIndex == 0,
            onTap: () => setState(() => _selectedIndex = 0),
            hoverColor: Colors.pink,
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.music),
            title: const Text('Create'),
            selected: _selectedIndex == 1,
            onTap: () => setState(() => _selectedIndex = 1),
            hoverColor: Colors.pink,
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.compactDisc),
            title: const Text('Library'),
            selected: _selectedIndex == 2,
            onTap: () => setState(() => _selectedIndex = 2),
            hoverColor: Colors.pink,
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.server),
            title: const Text('Network'),
            selected: _selectedIndex == 3,
            onTap: () => setState(() => _selectedIndex = 3),
            hoverColor: Colors.pink,
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.sliders),
            title: const Text('Settings'),
            selected: _selectedIndex == 4,
            onTap: () => setState(() => _selectedIndex = 4),
            hoverColor: Colors.pink,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const CreatePage();
      case 2:
        return const LibraryPage();
      case 3:
        return const NetworkPage();
      case 4:
        return const SettingsPage();
      default:
        return const HomePage();
    }
  }
}

class _MusicPlayerBar extends StatelessWidget {
  const _MusicPlayerBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 26, 25, 29),
        border: const Border(
          top: BorderSide(
            color: Colors.pink,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('No song playing'),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: () {},
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('00:00 / 00:00'),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: const Text(
        'Home Page Content',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(16),
      child: const Text(
        'Library Content Here',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(16),
      child: const Text(
        'Settings Content Here',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
