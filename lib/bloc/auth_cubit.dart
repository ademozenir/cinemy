import 'package:cinemy/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cinemy/tmdb/model/user.dart' as u;

class AuthCubit extends Cubit<u.User> {
  AuthCubit() : super(u.User.empty()) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        emit(u.User(user.uid, user.displayName ?? "", user.email ?? "", user.photoURL ?? ""));
      }
    });
  }

  var googleSignIn = getIt.get<GoogleSignIn>();

  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    if (googleUser != null) {
      var user = u.User(googleUser.id, googleUser.displayName ?? "", googleUser.email, googleUser.photoUrl ?? "");
      emit(user);
    }
  }

  void signOut() {
    googleSignIn.signOut();
    FirebaseAuth.instance.signOut();

    emit(u.User.empty());
  }
}
