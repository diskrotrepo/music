import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_app/network/network_models.dart' as network_models;
import 'package:music_app/network/network_repository.dart';
import 'package:logger/logger.dart';
import 'package:music_app/dependency_context.dart';
import 'package:music_app/networking/diskrot_network.dart';

class NetworkController extends ChangeNotifier {
  NetworkController({
    required this.networkRepository,
  });
  final NetworkRepository networkRepository;
  final Logger _logger = di.get<Logger>();

  Future<network_models.CreateInvitationResponse> createInvite() async {
    _logger.i("Creating invitation...");
    final invitationCreateResponse = await post("/invitations", jsonEncode({}));

    if (invitationCreateResponse.statusCode != 200) {
      _logger
          .e("Failed to create invitation: ${invitationCreateResponse.body}");
      throw Exception("Failed to create invitation");
    }

    final createInvitationResponse =
        network_models.CreateInvitationResponse.fromJson(
            jsonDecode(invitationCreateResponse.body));

    await networkRepository.createInvitation(createInvitationResponse.code);

    _logger.i("Invitation created: $invitationCreateResponse");
    return createInvitationResponse;
  }

  Future<List<network_models.Invitation>> getInvitations() async {
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
        network_models.AcceptInvitationResponse.fromJson(
            jsonDecode(response.body));

    await networkRepository.acceptInvitation(
        nickname: acceptInvitationResponse.nickname,
        direction: 'OUTBOUND',
        clientId: acceptInvitationResponse.clientId);

    return true;
  }

  Future<List<network_models.NetworkConnection>> getConnections() async {
    final connections = await networkRepository.getConnections();

    return connections;
  }

  Future<List<network_models.WorkQueue>> getQueue() async {
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
