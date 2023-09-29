import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/QuizQuestionmodel.dart';
import '../model/UserScoreModel.dart';


class exapBloc extends Cubit<Questions>{  
  exapBloc() : super(Questions(question_list: [],UserScore_list: []));
  
  
  void SetQuestions( List<String> item){

state.question_list.addAll(item);

 emit(Questions(question_list:state.question_list ,UserScore_list:state.UserScore_list ));
}

  void SetUserScores( List<UserScore> item){

state.UserScore_list.addAll(item);

 emit(Questions(question_list:state.question_list ,UserScore_list:state.UserScore_list ));
}

  void clearList() {
  emit(Questions(question_list: [],UserScore_list: []));
}
  

  
  }









  class Questions {

List<String> question_list ;
List<UserScore> UserScore_list;
Questions({required this.question_list ,required this.UserScore_list });






  }