import 'package:flutter/material.dart';

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
  final TextEditingController _inviteCodeController = TextEditingController();

  List<ConnectionItem> connections = [
    ConnectionItem(nickname: 'UserA', direction: 'Incoming'),
    ConnectionItem(nickname: 'UserB', direction: 'Outgoing'),
  ];

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

  void _acceptInvite() {
    final code = _inviteCodeController.text.trim();

    debugPrint('Accepting invite with code: $code');

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

  void _deleteConnection(ConnectionItem conn) {
    setState(() {
      connections.remove(conn);
    });
  }
}

class ConnectionItem {
  final String nickname;
  final String direction;
  ConnectionItem({required this.nickname, required this.direction});
}

class InvitationsTab extends StatefulWidget {
  const InvitationsTab({super.key});

  @override
  State<InvitationsTab> createState() => _InvitationsTabState();
}

class _InvitationsTabState extends State<InvitationsTab> {
  List<InvitationItem> invitations = [
    InvitationItem(nickname: 'Friend1', code: 'ABC123', status: 'Active'),
    InvitationItem(nickname: 'Friend2', code: 'XYZ789', status: 'Pending'),
  ];

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

  void _createInvite() {
    debugPrint('Creating invite...');
  }

  Widget _buildInvitationsTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Nickname')),
        DataColumn(label: Text('Code')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Delete')),
      ],
      rows: invitations.map((invite) {
        return DataRow(
          cells: [
            DataCell(Text(invite.nickname)),
            DataCell(Text(invite.code)),
            DataCell(Text(invite.status)),
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

  void _deleteInvitation(InvitationItem invite) {
    setState(() {
      invitations.remove(invite);
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
  // Example queue items
  List<QueueItem> queueItems = [
    QueueItem(
        id: 1, status: 'Pending', clientId: 'alexayers', submitted: '09:00 PM'),
    QueueItem(
        id: 2, status: 'Processing', clientId: 'UserC', submitted: '09:02 PM'),
  ];

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
      queueItems.clear();
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
      rows: queueItems.map((item) {
        return DataRow(
          cells: [
            DataCell(Text(item.id.toString())),
            DataCell(Text(item.status)),
            DataCell(Text(item.clientId)),
            DataCell(Text(item.submitted)),
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
