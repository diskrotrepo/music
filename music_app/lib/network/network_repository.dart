import 'package:drift/drift.dart';
import 'package:music_app/database/database.dart';
import 'package:music_app/database/tables.dart';
import 'package:logger/logger.dart';
import 'package:music_app/database/tables.drift.dart';
import 'package:music_app/dependency_context.dart';
import 'package:uuid/uuid.dart';

class NetworkRepository {
  NetworkRepository({required AppDatabase database}) : _database = database;
  final AppDatabase _database;
  final Logger _logger = di.get<Logger>();

  Future<void> acceptInvitation() async {}

  Future<List<Invitations>> getInvitations() async {
    final results = _database.select(_database.invitations).get();
    return results as List<Invitations>;
  }

  Future<void> createInvitation(String code) async {
    _database.invitations.insertOne(InvitationsCompanion(
      id: Value(Uuid().v4()),
      code: Value(code),
    ));
  }

  Future<void> deleteInvitation(String id) async {
    _database.delete(_database.invitations).where((tbl) => tbl.id.equals(id));
  }

  /*
  acceptInvitation = async (req: Request, res: Response): Promise<void> => {

        let invitation = db.prepare("SELECT * FROM invitations WHERE code = ?").get([req.params.code]);

        if (invitation) {
            res.status(400).json({ error: "You can't accept your own invitations." });
            return;
        }

        let response = await this.diskrotNetwork.post(`/invitations/${req.params.code}`, {});
        db.prepare("INSERT INTO connections (id, nickname, direction, client_id) VALUES (?,?,?,?)").run([uuid(), response.nickname, "OUTBOUND", response.client_id]);
        res.status(200).json({});
    }

  
    */
}

class Invitations {
  Invitations({
    required this.id,
    required this.clientAcceptedId,
    required this.code,
    required this.createdAt,
  });
  final String id;
  final String clientAcceptedId;
  final String code;
  final DateTime createdAt;
}
