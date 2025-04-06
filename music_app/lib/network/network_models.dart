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

class ConnectionsResponse {
  final List<NetworkConnection> connections;

  ConnectionsResponse({required this.connections});

  factory ConnectionsResponse.fromInboundJson(Map<String, dynamic> json) {
    var connectionsJson = json['connections'] as List<dynamic>;
    List<NetworkConnection> connectionsList = connectionsJson
        .map((connection) => NetworkConnection.fromInboundJson(
            connection as Map<String, dynamic>))
        .toList();

    return ConnectionsResponse(
      connections: connectionsList,
    );
  }

  factory ConnectionsResponse.fromOutboundJson(Map<String, dynamic> json) {
    var connectionsJson = json['connections'] as List<dynamic>;
    List<NetworkConnection> connectionsList = connectionsJson
        .map((connection) => NetworkConnection.fromOutboundJson(
            connection as Map<String, dynamic>))
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

  factory NetworkConnection.fromOutboundJson(Map<String, dynamic> json) {
    return NetworkConnection(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      direction: 'OUTBOUND', // Assuming outbound direction is fixed
      clientId: json['connected_to_client'] as String,
    );
  }

  factory NetworkConnection.fromInboundJson(Map<String, dynamic> json) {
    return NetworkConnection(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      direction: 'INBOUND',
      clientId: json['connected_to_client'] as String,
    );
  }
}
