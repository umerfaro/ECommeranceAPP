//this is singleton class to user user id
class SessionController {
  static final SessionController _singleton = SessionController._internal();

  late String? userId;

  factory SessionController() => _singleton;

  SessionController._internal(){
    userId = '';
  }

  void logout() {
    // Clearing the userId when logging out
    // You might want to perform additional cleanup here if needed
     userId = '';
  }
}
