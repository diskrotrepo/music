class CreateInvitationResponse {
  final String code;

  CreateInvitationResponse({required this.code});

  factory CreateInvitationResponse.fromJson(Map<String, dynamic> json) {
    return CreateInvitationResponse(
      code: json['code'] as String,
    );
  }
}

class AcceptInvitationResponse {
  final String nickname;
  final String clientId;

  AcceptInvitationResponse({
    required this.nickname,
    required this.clientId,
  });

  factory AcceptInvitationResponse.fromJson(Map<String, dynamic> json) {
    return AcceptInvitationResponse(
      nickname: json['nickname'] as String,
      clientId: json['client_id'] as String,
    );
  }
}

class GetInvitationsResponse {
  final List<Invitation> invitations;

  GetInvitationsResponse({required this.invitations});

  factory GetInvitationsResponse.fromJson(Map<String, dynamic> json) {
    var invitationsJson = json['invitations'] as List<dynamic>;
    List<Invitation> invitationsList = invitationsJson
        .map((invitation) =>
            Invitation.fromJson(invitation as Map<String, dynamic>))
        .toList();

    return GetInvitationsResponse(
      invitations: invitationsList,
    );
  }
}

class Invitation {
  final String nickname;
  final String clientId;
  final String code;

  Invitation({
    required this.nickname,
    required this.clientId,
    required this.code,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      nickname: json['nickname'] as String,
      clientId: json['client_id'] as String,
      code: json['code'] as String,
    );
  }
}

class ConnectionsResponse {
  final List<NetworkConnection> connections;

  ConnectionsResponse({required this.connections});

  factory ConnectionsResponse.fromJson(Map<String, dynamic> json) {
    var connectionsJson = json['connections'] as List<dynamic>;
    List<NetworkConnection> connectionsList = connectionsJson
        .map((connection) =>
            NetworkConnection.fromJson(connection as Map<String, dynamic>))
        .toList();

    return ConnectionsResponse(
      connections: connectionsList,
    );
  }
}

class NetworkConnection {
  final String id;
  final String nickname;
  final String direction;
  final String clientId;

  NetworkConnection({
    required this.id,
    required this.nickname,
    required this.direction,
    required this.clientId,
  });

  factory NetworkConnection.fromJson(Map<String, dynamic> json) {
    return NetworkConnection(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      direction: json['direction'] as String,
      clientId: json['connected_to_client'] as String,
    );
  }
}

class QueueResponse {
  final List<WorkQueue> workQueues;

  QueueResponse({required this.workQueues});

  factory QueueResponse.fromJson(Map<String, dynamic> json) {
    var queuesJson = json['queue'] as List<dynamic>;
    List<WorkQueue> workQueuesList = queuesJson
        .map((queue) => WorkQueue.fromJson(queue as Map<String, dynamic>))
        .toList();

    return QueueResponse(
      workQueues: workQueuesList,
    );
  }
}

class WorkQueue {
  final String id;
  final String clientId;
  final String createdAt;
  final String processingStatus;

  WorkQueue({
    required this.id,
    required this.clientId,
    required this.createdAt,
    required this.processingStatus,
  });

  factory WorkQueue.fromJson(Map<String, dynamic> json) {
    return WorkQueue(
      id: json['music_id'] as String,
      clientId: json['client_id'] as String,
      createdAt: json['dt_created'] as String,
      processingStatus: json['processing_status'] as String,
    );
  }
}
