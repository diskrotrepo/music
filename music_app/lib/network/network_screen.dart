import 'package:flutter/material.dart';
import 'package:music_app/database/tables.drift.dart';
import 'package:music_app/dependency_context.dart';
import 'package:music_app/network/network_controller.dart';

class NetworkPage extends StatelessWidget {
  const NetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Network'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Connections'),
              Tab(text: 'Invitations'),
              Tab(text: 'Queue'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ConnectionsTab(),
            InvitationsTab(),
            QueueTab(),
          ],
        ),
      ),
    );
  }
}

class ConnectionsTab extends StatefulWidget {
  const ConnectionsTab({super.key});

  @override
  State<ConnectionsTab> createState() => _ConnectionsTabState();
}

class _ConnectionsTabState extends State<ConnectionsTab> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final connections = await di.get<NetworkController>().getConnections();
    setState(() {
      this.connections = connections;
    });
  }

  final TextEditingController _inviteCodeController = TextEditingController();

  List<Network> connections = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This is a list of people who have agreed to share their GPU with you. '
            'You should only accept invitation codes from people you trust.',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _inviteCodeController,
                  decoration: const InputDecoration(
                    hintText: 'Enter invitation code',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: _acceptInvite,
                child: const Text('Accept Invite'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildConnectionsTable(),
          ),
        ],
      ),
    );
  }

  Future<void> _acceptInvite() async {
    final code = _inviteCodeController.text.trim();

    debugPrint('Accepting invite with code: $code');
    await di.get<NetworkController>().acceptInvitation(code);

    _inviteCodeController.clear();
  }

  Widget _buildConnectionsTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Nickname')),
        DataColumn(label: Text('Direction')),
        DataColumn(label: Text('Delete')),
      ],
      rows: connections.map((conn) {
        return DataRow(
          cells: [
            DataCell(Text(conn.nickname)),
            DataCell(Text(conn.direction)),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.grey),
                onPressed: () => _deleteConnection(conn),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  void _deleteConnection(Network conn) {
    setState(() {
      connections.remove(conn);
    });
  }
}

class InvitationsTab extends StatefulWidget {
  const InvitationsTab({super.key});

  @override
  State<InvitationsTab> createState() => _InvitationsTabState();
}

class _InvitationsTabState extends State<InvitationsTab> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    di.get<NetworkController>().getInvitations().then((invitations) {
      setState(() {
        this.invitations = invitations;
      });
    });
  }

  List<Invitation> invitations = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This is a list of people who are using your GPU. '
            'You should only share your invitation code with people you trust.',
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: _createInvite,
              child: const Text('Create Invite'),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildInvitationsTable(),
          ),
        ],
      ),
    );
  }

  void _createInvite() async {
    debugPrint('Creating invite...');
    final response = await di.get<NetworkController>().createInvite();
    debugPrint('Invite created: ${response.code}');
  }

  Widget _buildInvitationsTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Code')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Delete')),
      ],
      rows: invitations.map((invite) {
        return DataRow(
          cells: [
            DataCell(Text(invite.code.toString())),
            DataCell(Text('')),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.grey),
                onPressed: () => _deleteInvitation(invite),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  void _deleteInvitation(Invitation invitation) {
    setState(() {
      invitations.remove(invitation);
    });
  }
}

class InvitationItem {
  final String nickname;
  final String code;
  final String status;
  InvitationItem({
    required this.nickname,
    required this.code,
    required this.status,
  });
}

class QueueTab extends StatefulWidget {
  const QueueTab({super.key});

  @override
  State<QueueTab> createState() => _QueueTabState();
}

class _QueueTabState extends State<QueueTab> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    di.get<NetworkController>().getQueue().then((queue) {
      setState(() {
        this.queue = queue;
      });
    });
  }

  List<Queue> queue = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'These are current items set to be processed by the inference server.',
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: _clearQueue,
              child: const Text('Clear Queue'),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildQueueTable(),
          ),
        ],
      ),
    );
  }

  void _clearQueue() {
    setState(() {
      queue.clear();
    });

    debugPrint('Queue cleared.');
  }

  Widget _buildQueueTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('#')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Client ID')),
        DataColumn(label: Text('Submitted')),
      ],
      rows: queue.map((item) {
        return DataRow(
          cells: [
            DataCell(Text(item.id.toString())),
            DataCell(Text(item.processingStatus)),
            DataCell(Text(item.clientRequestedId)),
            DataCell(Text(item.createdAt.toString())),
          ],
        );
      }).toList(),
    );
  }
}

class QueueItem {
  final int id;
  final String status;
  final String clientId;
  final String submitted;
  QueueItem({
    required this.id,
    required this.status,
    required this.clientId,
    required this.submitted,
  });
}
