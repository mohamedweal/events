import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class fireStoreService {
  static final GoogleSignIn _google = GoogleSignIn.instance;
  static bool isInitialized = false;

  // initialize google sign in => identify app in google

  static Future<void> _initSignIn() async {
    if (!isInitialized) {
      await _google.initialize(
        serverClientId:
            '962892648759-v4s6mlmttjdo441fv94ib3u667n7oroj.apps.googleusercontent.com',
      );
    }
    isInitialized = true;
  }

  static Future<UserCredential> signInWithGoogle() async {
    _initSignIn();

    // User select The account => idToken ,accessToken

    GoogleSignInAccount account = await _google.authenticate();

    final idToken = account.authentication.idToken;
    final authClient = account.authorizationClient;
    GoogleSignInClientAuthorization? auth = await authClient
        .authorizationForScopes(['email', 'profile']);
    final accessToken = auth?.accessToken;

    //Tokens => Sign in with Firebase
    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
      accessToken: accessToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
