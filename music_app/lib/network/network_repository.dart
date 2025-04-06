import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:music_app/database/database.dart';
import 'package:logger/logger.dart';
import 'package:music_app/database/tables.drift.dart';
import 'package:music_app/dependency_context.dart';
import 'package:music_app/network/network_models.dart';
import 'package:music_app/networkiing/diskrot_network.dart';
import 'package:uuid/uuid.dart';

class NetworkRepository {
  NetworkRepository({required AppDatabase database}) : _database = database;
  final AppDatabase _database;
  final Logger _logger = di.get<Logger>();

  Future<void> acceptInvitation(
      {required String nickname,
      required String direction,
      required String clientId}) async {
    _logger.i("Accepting invitation...");
    await _database.into(_database.network).insert(
          NetworkCompanion(
            id: Value(Uuid().v4()),
            nickname: Value(nickname),
            direction: Value(direction),
            clientId: Value(clientId),
          ),
        );
    _logger.i("Invitation accepted: $nickname");
  }

  Future<List<Invitation>> getInvitations() async {
    final results = await _database.select(_database.invitation).get();
    return results;
  }

  Future<Invitation?> getInvitation(String code) async {
    final query = _database.select(_database.invitation);
    query.where((tbl) => tbl.code.equals(code));
    final results = await query.getSingleOrNull();
    return results;
  }

  Future<void> createInvitation(String code) async {
    _database.invitation.insertOne(InvitationCompanion(
      id: Value(Uuid().v4()),
      code: Value(code),
    ));
  }

  Future<void> deleteInvitation(String code) async {
    _database.invitation.deleteWhere((tbl) => tbl.code.equals(code));
  }

  Future<List<NetworkConnection>> getConnections() async {
    _logger.i("Fetching network connections...");

    final response = await get("/connections");

    if (response.statusCode != 200) {
      _logger.e("Failed to fetch connections: ${response.body}");
      return [];
    }

    final connectionsResponse =
        ConnectionsResponse.fromOutboundJson(jsonDecode(response.body));

    final connections = connectionsResponse.connections;

    final localConnections = await _database.select(_database.network).get();

    return connections;
  }

  Future<List<Queue>> getQueue() async {
    return await _database.select(_database.queue).get();
  }
}
