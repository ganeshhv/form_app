import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInController extends GetxController
{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future googleLogin() async{
    try {
      final googleUser =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);

      final User? user = authResult.user;
      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);
      final User? currentUser = _auth.currentUser;

      Map? model = {
        "uid": currentUser!.uid,
        "email": currentUser.email,
      };
      saveUserInfoToFireStore(currentUser, model);
      assert(user!.uid == currentUser.uid);
      // Get.toNamed('/homeView'); // navigate to your wanted page
      return;
    }
    catch(e){
      throw (e);
    }
  }

  Future saveUserInfoToFireStore(User fUser, Map? model) async
  {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "pwd": model!['pwd'],
      "name": model['name'],
      "phone": model['phone'],
    });
  }
  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    // Get.back(); // navigate to your wanted page after logout.
  }

}