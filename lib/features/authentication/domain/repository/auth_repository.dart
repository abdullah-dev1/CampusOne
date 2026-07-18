abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;

  AuthUser? get currentUser;

  Future<AuthUser> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> sendPasswordResetEmail(String email);

  Future<AuthUser> getCurrentUserData();
}

class AuthUser {
  final String uid;
  final String? email;
  final String role;
  final String? name;

  const AuthUser({
    required this.uid,
    this.email,
    required this.role,
    this.name,
  });
}