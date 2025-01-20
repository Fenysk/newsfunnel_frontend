import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static String get baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';
  static String get getExemple => baseUrl;

  // Auth
  static String get register => '$baseUrl/auth/register';
  static String get login => '$baseUrl/auth/login';
  static String get logout => '$baseUrl/auth/logout';
  static String get refresh => '$baseUrl/auth/refresh';

  // Users
  static String get getMyProfile => '$baseUrl/users/my-profile';
  static String get getUserProfile => '$baseUrl/users/profile';
  static String get checkIfPseudoExist => '$baseUrl/users/check-pseudo';

  // Mails
  static String get getUserMailServers => '$baseUrl/mails/getUserMailServers';
  static String get getMailsFromAddress => '$baseUrl/mails/fetch-all';
  static String get getMailDetails => '$baseUrl/mails/get-details';
  static String get deleteMail => '$baseUrl/mails/delete';
}
