import "dart:developer";
// import "models/user.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:g1/base.dart";
import "package:g1/controller/pAuth.dart";
import "package:provider/provider.dart";

class AuthService {
  final String firstCollection = "first_collection";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based on the firebase User
  // MyUser? _userFromFirebase(User? user) {
  //   return user != null ? MyUser(uid: user.uid, email: user.email ?? "", name: user.email??"", phone: user.phoneNumber??"", isAnonymous: user.isAnonymous) : null;
  // }
  // auth  change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // sign in anonymous
  Future<User?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return (user);
    } catch (e) {
      log("execption : sign in anonymous function");
      log(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future<User?> signinEmailPass(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Base()));
      if (credential.user != null) {
        Provider.of<Pauth>(context, listen: false).uIDSet(credential.user!.uid);
      }
      return (credential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        log('invalid-email');
      } else if (e.code == 'invalid-email-verified') {
        log('invalid-email-verified');
      } else if (e.code == 'invalid-password') {
        log('invalid-password');
      } else if (e.code == 'uid-already-exists') {
        log('uid-already-exists');
      }
      return null;
    }
  }

  // sign register with email & password
  Future<User?> registerEmailPass(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      log("registered and returned User");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Base()));
      if (credential.user != null) {
        Provider.of<Pauth>(context, listen: false).uIDSet(credential.user!.uid);
      }
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        log('invalid-email');
      } else if (e.code == 'invalid-email-verified') {
        log('invalid-email-verified');
      } else if (e.code == 'invalid-password') {
        log('invalid-password');
      } else if (e.code == 'uid-already-exists') {
        log('uid-already-exists');
      }
      return null;
    } catch (e) {
      log("error in firebase creating user with email and password $e");
      return null;
    }
  }

  // sign out
  Future singOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
