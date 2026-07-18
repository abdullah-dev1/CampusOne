import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Creates Firebase Auth accounts on behalf of the admin
/// without signing the admin out, using a temporary secondary app.
class AdminAccountService {
  Future<String> createAuthAccount({
    required String email,
    required String password,
  }) async {
    FirebaseApp? tempApp;

    try {
      tempApp = await Firebase.initializeApp(
        name: 'AdminAccountCreation_${DateTime.now().millisecondsSinceEpoch}',
        options: Firebase.app().options,
      );

      final tempAuth = FirebaseAuth.instanceFor(app: tempApp);

      final credential = await tempAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      await tempAuth.signOut();

      return uid;
    } finally {
      if (tempApp != null) {
        await tempApp.delete();
      }
    }
  }
}