import 'dart:math';
import '../../../../../core/utils/password_generator.dart';
class PasswordGenerator {
  static String generate({int length = 10}) {
    const chars =
        'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789';
    final random = Random.secure();
    return List.generate(
      length,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }
}