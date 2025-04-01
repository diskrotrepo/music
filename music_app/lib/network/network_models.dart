class AcceptInvitationResponse {
  final String code;

  AcceptInvitationResponse({required this.code});

  factory AcceptInvitationResponse.fromJson(Map<String, dynamic> json) {
    return AcceptInvitationResponse(
      code: json['code'] as String,
    );
  }
}
