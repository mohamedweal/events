import 'package:events/database/UsersDao.dart';
import 'package:events/database/model/events.dart';
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

  bool isFavorite(Event event){
    return _databaseUser?.favorites.contains(event.id)?? false;
  }
  AppUser? getUser(){
    return _databaseUser;
  }
  void updateFavorites(List<String> favorites){
    _databaseUser?.favorites = favorites;
  }

  void logout(){
    _fb_authService.signOut();
    _databaseUser = null;
    _fbAuthUser = null;
    notifyListeners();
  }

  void retrieveUserFromDatabase()async{
    if(_fbAuthUser!=null){
      _databaseUser = await UsersDao.getUserById(_fbAuthUser?.uid);
      notifyListeners();
    }
  }
  var _fb_authService = FirebaseAuth.instance; // singleton

  bool isLoggedInBefore(){
    var user = FirebaseAuth.instance.currentUser;

    if(user == null){
      return false;
    }

    return true;
  }
  Future<AuthResponse> register(String email,
      String password,
      String name,
      String phone)async{
    try {

      final credential = await _fb_authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      AppUser user = AppUser(
        id: credential.user?.uid,
        name: name,
        phone: phone,
        email: email,
      );

      await UsersDao.addUser(user);
      _databaseUser = user;
      _fbAuthUser = credential.user;
      return AuthResponse(success: true, credential: credential,);

    } on FirebaseAuthException catch (e) {
      if (e.code == AuthFailure.weakPassword.code) {
        return AuthResponse(success: false, failure: AuthFailure.weakPassword);
      } else if (e.code == AuthFailure.emailAlreadyUsed.code ) {
        return AuthResponse(success: false, failure: AuthFailure.emailAlreadyUsed);
      }
    } catch (e) {
    }
    return AuthResponse(success: false, failure: AuthFailure.general);

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
      return AuthResponse(success: true, credential: credential,
          user: user);
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthFailure.invalidCredentials.code) {
        return AuthResponse(success: false, failure: AuthFailure.invalidCredentials);
      }
    } catch (e) {
    }
    return AuthResponse(success: false, failure: AuthFailure.general);


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
  invalidCredentials("invalid-credential"),
  general('Something went wrong');

  final String code;
  const AuthFailure(this.code);

}