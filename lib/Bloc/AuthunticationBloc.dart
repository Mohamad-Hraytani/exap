import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthunticationBloc extends Cubit<Authuntication>{  


  AuthunticationBloc() : super(Authuntication(usid:"", name: ""));
    final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  Future<void> signInWithGoogle() async {

    try {
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return ;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
 await  _auth.signInWithCredential(credential);
       var userCredential = await _auth.signInWithCredential(credential);
       state.usid = userCredential.user!.uid.toString();
       state.name =  userCredential.user!.displayName.toString();
emit(Authuntication(usid: state.usid,name: state.name));

    } catch (e) {
      print('Error signing in with Google: $e');
     
      
    }
  }



void signOutGoogle() async{
  await _googleSignIn.signOut();
  await _auth.signOut();
  print("User Sign Out");

emit(Authuntication(usid: state.usid , name: state.name));
}





}





class Authuntication {
String usid ;
String name;
  Authuntication({ required this.usid, required this.name});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();




}