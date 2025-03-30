import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Network'),
              Tab(text: 'GPU'),
              Tab(text: 'Prompts'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NetworkSettingsTab(),
            GPUSettingsTab(),
            PromptsSettingsTab(),
          ],
        ),
      ),
    );
  }
}

class NetworkSettingsTab extends StatefulWidget {
  const NetworkSettingsTab({super.key});

  @override
  State<NetworkSettingsTab> createState() => _NetworkSettingsTabState();
}

class _NetworkSettingsTabState extends State<NetworkSettingsTab> {
  final TextEditingController _nicknameController =
      TextEditingController(text: 'alexayers');
  bool _sharingEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sharing',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'In order to share your GPU you need to enable sharing. '
            'Your nickname will be seen by anyone that connects to you.',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nicknameController,
                  decoration: const InputDecoration(
                    labelText: 'Nickname',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: _toggleSharing,
                child: Text(_sharingEnabled ? 'Disable' : 'Enable'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleSharing() {
    setState(() {
      _sharingEnabled = !_sharingEnabled;
    });
  }
}

class GPUSettingsTab extends StatefulWidget {
  const GPUSettingsTab({super.key});

  @override
  State<GPUSettingsTab> createState() => _GPUSettingsTabState();
}

class _GPUSettingsTabState extends State<GPUSettingsTab> {
  final TextEditingController _hostnameController =
      TextEditingController(text: 'http://213.181.111.2');
  final TextEditingController _portController =
      TextEditingController(text: '50688');
  final TextEditingController _queueSizeController =
      TextEditingController(text: '20');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Inference Service',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _hostnameController,
            decoration: const InputDecoration(
              labelText: 'Hostname',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _portController,
            decoration: const InputDecoration(
              labelText: 'Port',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _queueSizeController,
            decoration: const InputDecoration(
              labelText: 'Max Queue Size',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: _saveGPUSettings,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _saveGPUSettings() {
    final hostname = _hostnameController.text.trim();
    final port = _portController.text.trim();
    final maxQueueSize = _queueSizeController.text.trim();

    // For example, store in shared preferences or make an API call
    debugPrint('Saving GPU settings: $hostname:$port, queue=$maxQueueSize');
  }
}

class PromptsSettingsTab extends StatefulWidget {
  const PromptsSettingsTab({super.key});

  @override
  State<PromptsSettingsTab> createState() => _PromptsSettingsTabState();
}

class _PromptsSettingsTabState extends State<PromptsSettingsTab> {
  final TextEditingController _lrcPromptController = TextEditingController(
    text:
        '''Take the input, and produce a Simple LRC format file which takes into account time ...
[example text goes here]''',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LRC Prompt',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'This prompt is used to generate an LRC file which determines where your words are placed within a song in time.',
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TextField(
              controller: _lrcPromptController,
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: _savePrompt,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _savePrompt() {
    final promptText = _lrcPromptController.text;
    debugPrint('Saving LRC prompt:\n$promptText');
  }
}
