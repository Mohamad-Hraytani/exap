import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../Bloc/AuthunticationBloc.dart';
import '../Bloc/ExapBloc.dart';



class SettingsWidget extends StatefulWidget {


  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {


bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.transparent,

body: Center(
  child:   Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
     
Container(
         width: 200,
         height: 40,
         decoration: BoxDecoration(
         color:Colors.white,
        borderRadius: BorderRadius.circular(10), 
         
         
         ),
         child:   TextButton(
         
         style: TextButton.styleFrom(
        
         //fixedSize: Size(200,)
         ),
         onPressed: (){



                         context.read<AuthunticationBloc>().signOutGoogle(); 




         }, child: Text("Sign Out",style: TextStyle(color: Color(0xFF253F5D) ),)
         ),
         ),






    ],
  ),
),

    );
  }
}