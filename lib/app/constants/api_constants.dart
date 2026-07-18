class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "http://10.0.2.2:5000/api";

  static const String login = "$baseUrl/auth/login";
  static const String logout = "$baseUrl/auth/logout";
  static const String profile = "$baseUrl/auth/profile";
}