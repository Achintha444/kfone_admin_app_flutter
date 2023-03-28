/// Class to hold the session token
class SessionToken {
  final String? accessToken;
  final String? idToken;
  final DateTime? accessTokenExpirationDateTime;

  const SessionToken({
    required this.accessToken,
    required this.idToken,
    required this.accessTokenExpirationDateTime,
  });
}
