






import 'package:uas_sosialmedia/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String emai, String password);
  Future<AppUser?> registerWithEmailPassword(
    String name, String email, String password);
    Future<void> logout();
    Future<AppUser?> getCurrentUser();
}