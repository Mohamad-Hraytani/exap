import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Bloc/AuthunticationBloc.dart';

class login extends StatefulWidget {
  

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      
      body:
    Center(
      child: Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
              color:Colors.white ,
             borderRadius: BorderRadius.circular(10), 
              
              
              ),
              child:   Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              
               SizedBox(
                   width: 20,
                   height: 20,
                   
                   child: Image.asset("assets/google.png",fit: BoxFit.contain,)),
                TextButton(
                
                  style: TextButton.styleFrom(
                 
                //fixedSize: Size(200,)
                ),
                  onPressed: (){
    
    
    BlocProvider.of<AuthunticationBloc>(context).signInWithGoogle();
    
    
    
    
                  },
                   child: Text("sign up with google",
                   style: TextStyle(color: Colors.black),)
                ),
              ],
              ),
              ),
    )
      
      
      
      
      
      
      
    
      );










  }



}