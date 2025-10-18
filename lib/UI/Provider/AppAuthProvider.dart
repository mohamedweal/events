import 'package:events/database/UsersDao.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:events/database/model/AppUser.dart';

class AppAuthProvider extends ChangeNotifier{

  // save users in memory
  var _fbAuthUser = FirebaseAuth.instance.currentUser;
  AppUser? _databaseUser;

  AppAuthProvider(){
    retrieveUserFromDatabase();
  }

  AppUser? getUser(){
    return _databaseUser;
  }
  void logout(){
    _fb_authService.signOut();
    _databaseUser = null;
    _fbAuthUser = null;
    notifyListeners();
  }

  void retrieveUserFromDatabase()async{
    var user = FirebaseAuth.instance.currentUser; // Use the current user directly

    if(user != null){
      // 1. Ensure the database user is retrieved.
      AppUser? fetchedUser = await UsersDao.getUserById(user.uid);

      // 2. Check for null and update state
      if (fetchedUser != null) {
        _databaseUser = fetchedUser;
      }
      // 3. Update the Firebase user state
      _fbAuthUser = user;

      // 4. Notify listeners AFTER all user data is loaded
      notifyListeners();
    }
    // If user is null, notifyListeners is still important to update the UI (e.g., to show LoginScreen)
    notifyListeners();
  }
  var _fb_authService = FirebaseAuth.instance; // singleton

  bool isLoggedInBefore(){
    var user = FirebaseAuth.instance.currentUser;

    if(user == null){
      return false;
    }

    return true;
  }
  // In lib/UI/Provider/AppAuthProvider.dart

  Future<AuthResponse> register(String email,
      String password,
      String name,
      String phone)async{
    try {

      final credential = await _fb_authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // We check if the Firebase Auth creation was successful before proceeding
      if (credential.user == null) {
        // This case should not happen if no exception was thrown, but is good for safety.
        return AuthResponse(success: false, failure: AuthFailure.general);
      }

      AppUser user = AppUser(
        // Use non-null safe access here, as we checked above
        id: credential.user!.uid,
        name: name,
        phone: phone,
        email: email,
      );

      // 🚨 THIS IS THE LINE THAT WAS LIKELY FAILING SILENTLY 🚨
      await UsersDao.addUser(user);

      _databaseUser = user;
      _fbAuthUser = credential.user;
      notifyListeners(); // Notify UI of successful registration
      return AuthResponse(success: true, credential: credential,);

    } on FirebaseAuthException catch (e) {
      // Return specific AuthFailure for known Firebase errors
      return AuthResponse(
          success: false,
          failure: AuthFailure.values.firstWhere(
                  (f) => f.code == e.code,
              orElse: () => AuthFailure.general // default to general if code is unknown
          )
      );
    } catch (e) {
      // 🚨 Critical: Log the error from Firestore/DAO here 🚨
      print('REGISTER FAILED WITH NON-FIREBASEAUTH EXCEPTION: $e');
      // Return a general failure for the UI
      return AuthResponse(success: false, failure: AuthFailure.general);
    }
  }


  Future<AuthResponse> login(String email,
      String password,
      )async{

    try {

      final credential = await _fb_authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //retrieve user from db
      AppUser? user = await UsersDao.getUserById(credential.user?.uid);
      _databaseUser = user;
      _fbAuthUser = credential.user;
      notifyListeners(); // Notify UI of successful login
      return AuthResponse(success: true, credential: credential,
          user: user);
    } on FirebaseAuthException catch (e) {

      // 🚨 DEBUG CODE TO IDENTIFY THE ERROR 🚨
      print('LOGIN FAILED CODE: ${e.code}');

      // Check for common sign-in errors and return the most specific failure type
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        // We map both of these to invalidCredentials for security reasons (don't reveal which is wrong)
        return AuthResponse(success: false, failure: AuthFailure.invalidCredentials);
      } else if (e.code == 'user-disabled') {
        return AuthResponse(success: false, failure: AuthFailure.userDisabled);
      } else if (e.code == 'too-many-requests') {
        return AuthResponse(success: false, failure: AuthFailure.tooManyRequests);
      } else if (e.code == 'network-request-failed') {
        return AuthResponse(success: false, failure: AuthFailure.networkError);
      }

      // If it's an unhandled known error, return general
      return AuthResponse(success: false, failure: AuthFailure.general);

    } catch (e) {
      // General catch block for other exceptions
      print('General login error: $e');
      return AuthResponse(success: false, failure: AuthFailure.general);
    }
  }
}

class AuthResponse {
  bool success;
  AuthFailure? failure;
  UserCredential? credential;
  AppUser? user;
  AuthResponse({required this.success, this.failure, this.credential,
    this.user});
}

enum AuthFailure{
  weakPassword('weak-password'),
  emailAlreadyUsed('email-already-in-use'),
  invalidCredentials('user-not-found'),
  userDisabled('user-disabled'),
  tooManyRequests('too-many-requests'),
  networkError('network-request-failed'),
  general('Something went wrong');

  final String code;
  const AuthFailure(this.code);
}