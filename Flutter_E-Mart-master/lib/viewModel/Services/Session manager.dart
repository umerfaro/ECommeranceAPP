

class SessionController {
  static final SessionController _singleton = SessionController._internal();

  String? userId;

  factory SessionController() => _singleton;

  SessionController._internal() : userId = '';

  void logout() {
    userId = ''; // Clearing the userId when logging out
    // Additional cleanup logic can be added here if needed
  }
}
