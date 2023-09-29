import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/AuthunticationBloc.dart';
import '../Bloc/ExapBloc.dart';
import '../model/UserScoreModel.dart';

class leaderboard extends StatefulWidget {


  @override
  State<leaderboard> createState() => _leaderboardState();
}

class _leaderboardState extends State<leaderboard> {
 List<UserScore> items =[];

@override
  void initState() {
    super.initState();

 getUsersAndScores().then((_) {

  setState(() {
items =BlocProvider.of<exapBloc>(context).state.UserScore_list;
items.sort((a, b)=> b.   score.compareTo(a.score));

  });
});


  }


Future<void> getUsersAndScores() async {
  final querySnapshot = await FirebaseFirestore.instance.collection('scores').get();

   BlocProvider.of<exapBloc>(context).SetUserScores(
  querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserScore(
      userId: doc.id,
      score: data['score'] as int,
      name: data['name'] as String,
    );
  }).toList());


}


@override
  void dispose() {

    super.dispose();
    items.clear();
      exapBloc().clearList();
  }

  @override
  Widget build(BuildContext context) {
          return 
          ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
   
          return Card(
          margin: EdgeInsets.all(16.0),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(items[index].name ,style: TextStyle(fontSize: 20), ),
   Text("-" ,style: TextStyle(fontSize: 20), ),
                   Text(items[index].score.toString(),style: TextStyle(fontSize: 20),),

   
            

  
            ],
          ),
          );
        },
      );
          
          
          

              
              
              
              
              
             
  }
}