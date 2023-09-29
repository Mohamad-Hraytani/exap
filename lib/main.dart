import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';





import 'Bloc/AuthunticationBloc.dart';
import 'Bloc/ExapBloc.dart';
import 'Screen/Hompage.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'Screen/login.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

 OneSignal.shared.setAppId("64c07957-31ac-4b7c-845f-8945de3fe8a8");

  runApp(MyApp() );
   
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

return 
MultiBlocProvider(
      providers: [


 BlocProvider<AuthunticationBloc>( 
        create: (context) => AuthunticationBloc(),
          child:Homepage() ,
),
 BlocProvider<exapBloc>( 
        create: (context) => exapBloc(),
          child:Homepage() ,
),
      ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        debugShowMaterialGrid: false,
        home: AuthenticationWrapper()) ,
    );







  }
}

class AuthenticationWrapper extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state, show a loading indicator or splash screen
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          if (snapshot.hasData) {
            // User is logged in, navigate to the home screen
            return BlocProvider( 
        create: (BuildContext context) => AuthunticationBloc(),
        child:Homepage() ,
);
          } else {
            // User is not logged in, navigate to the login/signup screen
            return  BlocProvider( 
        create: (BuildContext context) => AuthunticationBloc(),
        child:login() ,
);
          }
        }
      },
    );
  }
  
  
  }
