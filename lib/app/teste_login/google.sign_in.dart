import 'package:alliance/firebase_script/scripts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    nome = user.displayName.toString();
    email = user.email.toString();
    idToken = user.id.toString();
    empresa = '';

    db.collection("vendedor_").doc(user.displayName).set({
      "nome": user.displayName,
      "email": user.email,
      "id": user.id,
    });

    notifyListeners();
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
