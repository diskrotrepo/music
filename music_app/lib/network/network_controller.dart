import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_app/configuration/configuration.dart';
import 'package:music_app/database/tables.drift.dart';
import 'package:music_app/network/network_models.dart';
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

  Future<CreateInvitationResponse> createInvite() async {
    _logger.i("Creating invitation...");
    final invitationCreateResponse = await post("/invitations", jsonEncode({}));

    if (invitationCreateResponse.statusCode != 200) {
      _logger
          .e("Failed to create invitation: ${invitationCreateResponse.body}");
      throw Exception("Failed to create invitation");
    }

    final createInvitationResponse = CreateInvitationResponse.fromJson(
        jsonDecode(invitationCreateResponse.body));

    await networkRepository.createInvitation(createInvitationResponse.code);

    _logger.i("Invitation created: $invitationCreateResponse");
    return createInvitationResponse;
  }

  Future<List<Invitation>> getInvitations() async {
    return networkRepository.getInvitations();
  }

  Future<bool> acceptInvitation(String code) async {
    final invitation = await networkRepository.getInvitation(code);

    if (invitation != null) {
      _logger.e("You can't accept your own invitations.");
      return false;
    }
    final response = await post("/invitations/$code", jsonEncode({}));

    if (response.statusCode != 200) {
      _logger.e("Failed to accept invitation: ${response.body}");
      throw Exception("Failed to accept invitation");
    }

    final acceptInvitationResponse =
        AcceptInvitationResponse.fromJson(jsonDecode(response.body));

    await networkRepository.acceptInvitation(
        nickname: acceptInvitationResponse.nickname,
        direction: 'OUTBOUND',
        clientId: acceptInvitationResponse.clientId);

    return true;
  }

  Future<List<Network>> getConnections() async {
    return await networkRepository.getConnections();
  }

  Future<List<Queue>> getQueue() async {
    return await networkRepository.getQueue();
  }

  Future<void> deleteInvitation(String code) async {
    debugPrint("Deleting invitation with code: $code");
    final response = await delete("/invitations/$code");
    if (response.statusCode != 200) {
      _logger.e("Failed to delete invitation: ${response.body}");
      throw Exception("Failed to delete invitation");
    }
    await networkRepository.deleteInvitation(code);
    _logger.i("Invitation deleted: $code");
  }
}
