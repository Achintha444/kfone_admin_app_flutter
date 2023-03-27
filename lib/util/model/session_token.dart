/// Class to hold the session token
class SessionToken {
  final String? accessToken;
  final String? idToken;

  const SessionToken({
    required this.accessToken,
    required this.idToken,
  });
}
