import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// checks if user is signed in  or not, returns true and false respectively
  bool checkUser() {
    if (firebaseAuth.currentUser != null) return true;
    return false;
  }

  ///Sign in to firebase auth
  Future<User> signInWithEmailAndPassword({email, password}) async {
    var user;

    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return Future.error("User Not Found");
      } else if (e.code == "wrong-password") {
        return Future.error("Invalid Password");
      } else if (e.code == "invalid-email") {
        return Future.error("Invalid Email Address");
      } else {
        return Future.error(e.message.toString());
      }
    } on SocketException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
    if (user != null)
      return user;
    else
      return null;
    // notifyListeners();
  }

  ///Sign up to firebase auth
  Future<User> signUpWithEmailAndPassword({email, password}) async {
    User user;
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return Future.error("User Not Found");
      } else if (e.code == "wrong-password") {
        return Future.error("Invalid Password");
      } else if (e.code == "invalid-email") {
        return Future.error("Invalid Email Address");
      } else {
        return Future.error(e.message.toString());
      }
    } on SocketException catch (e) {
      debugPrint(e.message);
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }

    // CloudStore().initUserProfile(user);

    return user;
  }

  Future<void> forgotPassword({email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message);
    } catch (e) {
      return Future.error(e);
    }
  }

//sign out from firebase auth
  Future<void> signout() async {
    await firebaseAuth.signOut();
    debugPrint("Signed out successfully");
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth
          .sendPasswordResetEmail(email: email)
          .then((value) => debugPrint("Email sent successfully!"));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return Future.error("User doesn't exist!");
      } else if (e.code == "invalid-email") {
        return Future.error("Invalid email address");
      } else {
        return Future.error(e.message.toString());
      }
    } on SocketException catch (e) {
      debugPrint(e.message);
      return Future.error("Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> confirmPasswordReset(String code, String newPassword) async {
    try {
      await firebaseAuth.confirmPasswordReset(
          code: code, newPassword: newPassword);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message.toString());
    } on SocketException catch (e) {
      debugPrint(e.message);
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
    debugPrint("Password Reseted Successfully!");
  }

  static Future<User> signInWithGoogle({@required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

  static Future<PhoneAuthProvider> verifyPhoenNo(String phoneNo) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: Duration(seconds: 100),
        verificationCompleted: (phoneCredential) async {
          await FirebaseAuth.instance.currentUser
              .linkWithCredential(phoneCredential)
              .then((value) {
            debugPrint("Number linked to account successfully");
            return;
          }).catchError((e) {
            debugPrint("linking failed with error: $e");
            return Future.error(e);
          });
          debugPrint("Verification Completed");
        },
        verificationFailed: (e) {
          debugPrint("failed: " + e.code);
        },
        codeSent: (verificationId, resendToken) {
          debugPrint("resendToken is: " + resendToken.toString());
        },
        codeAutoRetrievalTimeout: (v) {
          debugPrint("Code Timeout!");
        });
    return null;
  }
}
