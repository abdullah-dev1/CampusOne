import '../../../../core/services/auth_service.dart';
import '../../domain/repository/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final AuthService _authService;

  FirebaseAuthRepository(this._authService);

  @override
  Stream<AuthUser?> get authStateChanges {
    // AuthService doesn't currently expose a stream; using currentUser as a fallback.
    // If you add a stream getter to AuthService later, wire it here instead.
    return Stream.value(currentUser);
  }

  @override
  AuthUser? get currentUser {
    final user = _authService.currentUser;
    if (user == null) return null;

    return AuthUser(
      uid: user.uid,
      email: user.email,
      role: "unknown",
    );
  }

@override
Future<AuthUser> signIn({
  required String email,
  required String password,
}) async {
  print("STEP 1");

 await _authService.login(
  email: email,
  password: password,
).timeout(
  const Duration(seconds: 15),
  onTimeout: () {
    throw Exception("Network request timed out. Check your internet connection.");
  },
);

  print("STEP 2");

  final user = await getCurrentUserData();

  print("STEP 3");

  return user;
}

  @override
  Future<void> signOut() async {
    await _authService.logout();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _authService.sendResetEmail(email);
  }

@override
Future<AuthUser> getCurrentUserData() async {
  print("STEP 4");

  final doc = await _authService.getCurrentUserDocument();

  print("STEP 5");

  final data = doc.data();

  print("STEP 6");

  final user = _authService.currentUser!;

  print("STEP 7");

  return AuthUser(
    uid: user.uid,
    email: user.email,
    role: data?['role'] ?? "unknown",
    name: data?['name'],
  );
}

  
}