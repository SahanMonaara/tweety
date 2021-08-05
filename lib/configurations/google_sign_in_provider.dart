import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tweety/utils/app_constants.dart';
import 'package:tweety/utils/injection_container.dart';

import 'app_shared_data.dart';

class GoogleSignInProvider extends ChangeNotifier{
final googleSignIn = GoogleSignIn();
final sharedData = sl<AppSharedData>();
GoogleSignInAccount ? _user;

GoogleSignInAccount get user => _user!;

Future googleLogin() async{
 try{
   final googleUser = await googleSignIn.signIn();
   ///If user have not selected an account
   if(googleUser == null) return;
   ///User selected an account
   _user = googleUser;

   final googleAuthentication = await googleUser.authentication;

   ///Google authentication credentials
   final credentials = GoogleAuthProvider.credential(
       accessToken: googleAuthentication.accessToken,
       idToken: googleAuthentication.idToken
   );

   await FirebaseAuth.instance.signInWithCredential(credentials);
   notifyListeners();
 }catch (e){
   print("FIREBASE_ERROR" + e.toString());
 }
}

/// Sign out from google
Future logout() async{
  try{
    await sharedData.clearData("ID");
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }catch(e){
    print("FIREBASE_ERROR" + e.toString());
  }

}
}
