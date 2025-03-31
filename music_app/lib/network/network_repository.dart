import 'package:music_app/database/database.dart';
import 'package:music_app/database/tables.dart';
import 'package:logger/logger.dart';
import 'package:music_app/dependency_context.dart';

class NetworkRepository {
  NetworkRepository({required AppDatabase database}) : _database = database;
  final AppDatabase _database;
  final Logger _logger = di.get<Logger>();

  Future<void> acceptInvitation() async {}

  Future<List<Invitations>> getInvitations() async {
    /* final invitations = _database
        .prepare("SELECT * FROM invitations")
        .all()
        .cast<Invitations>();
    return invitations;*/
    return [];
  }

  Future<String> createInvitation() async {
    /*
    final invitationCreateResponse =
        await _diskrotNetwork.post("/invitations", {});
    _database
        .prepare("INSERT INTO invitations (id, code) VALUES (?,?)")
        .run([uuid(), invitationCreateResponse.code]);
    return invitationCreateResponse;*/
    return "";
  }

  Future<void> deleteInvitation() async {
    /*
    _database
        .prepare("DELETE FROM invitations WHERE id = ?")
        .run([req.params.id]);*/
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

    getInvitations = async (req: Request, res: Response): Promise<void> => {

        let invitations = db.prepare("SELECT * FROM invitations").all();
        res.status(200).json(invitations);
    }

    createInvitation = async (req: Request, res: Response): Promise<void> => {

        let invitationCreateResponse = await this.diskrotNetwork.post("/invitations", {}) as InvitationCreateResponse;
        db.prepare("INSERT INTO invitations (id, code) VALUES (?,?)").run([uuid(), invitationCreateResponse.code]);
        res.status(200).json(invitationCreateResponse);
    }

    deleteInvitation = async (req: Request, res: Response): Promise<void> => {
        db.prepare("DELETE FROM invitations WHERE id = ?").run([req.params.id]);
        res.status(200).json({});
    }
    */
}

class Invitations {
  final String id;
  final String code;

  Invitations({required this.id, required this.code});
}
