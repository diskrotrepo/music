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
