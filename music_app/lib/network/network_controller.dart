import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_app/configuration/configuration.dart';
import 'package:music_app/network/network_repository.dart';
import 'package:logger/logger.dart';
import 'package:music_app/dependency_context.dart';
import 'package:music_app/networkiing/diskrot_network.dart';

class NetworkController extends ChangeNotifier {
  NetworkController({
    required this.networkRepository,
  });
  final NetworkRepository networkRepository;
  final Logger _logger = di.get<Logger>();

  Future<String> createInvite() async {
    _logger.i("Creating invitation...");
    final invitationCreateResponse = post("/invitations", jsonEncode({}));

    _logger.i("Invitation created: $invitationCreateResponse");
    return "";
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
