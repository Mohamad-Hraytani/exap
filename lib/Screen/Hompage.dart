import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exap/Screen/Settings.dart';
import 'package:exap/Screen/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../Bloc/AuthunticationBloc.dart';
import '../Bloc/ExapBloc.dart';
import '../model/QuizQuestionmodel.dart';

class Homepage extends StatefulWidget {


  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>  with TickerProviderStateMixin {



bool show_result = false;
 
  int result1 =-1;
  int result2= -1;
  int result3 = -1;
 List<QuizQuestion> questions =[];
late TabController tc;


 List<String> items =[];
@override
  void initState() {

OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
  event.complete(event.notification);
});

OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
setState(() {
  tc.index = 1;
});
});

  


    super.initState();
 tc = TabController( initialIndex: 0,length: 2, vsync: this);


FirebaseFirestore.instance.collection('exap').snapshots().listen((event) {
   BlocProvider.of<exapBloc>(context).SetQuestions(event.docs
              .map((document) => document['data'] as String)
              .toList());
 items =BlocProvider.of<exapBloc>(context).state.question_list ;


items.forEach((element) {
  var u = new QuizQuestion(element, ["2", "4", "6"]);
setState(() {
  questions.add(u);
});


});

 });

  }



@override
  void dispose() {

    super.dispose();
    questions.clear();
    items.clear();
    exapBloc().clearList();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  drawer:Drawer(
        backgroundColor: Colors.transparent,
        width: MediaQuery.of(context).size.width * 0.6,
        
        child: SettingsWidget() ,),
appBar: AppBar(

bottom: TabBar(
    isScrollable: true,
    labelColor: Colors.black, 
    indicatorWeight: 4, 
    indicatorColor: Colors.black,
    //indicatorPadding:EdgeInsets.symmetric(horizontal: 25),
    tabs:[
        Tab(text: 'test',icon: Icon(Icons.psychology_alt_outlined)),
        Tab(text: 'leaderboard',icon: Icon(Icons.tour_sharp)),
        
       ],
    controller: tc,), 

),


body: 
TabBarView(
  controller:tc ,
  children:[

 Container(
  width: MediaQuery.of(context).size.width,
    child: 
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Container(
            height:  500,
            child: 
             Builder(
              builder: (context) {
                return ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
                final question = questions[index];
                return Card(
                margin: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(question.question),
                    ),
                    Column(
                      children: question.choices.asMap().entries.map((entry) {
                        final int choiceIndex = entry.key;
                        final String choice = entry.value;
                        return RadioListTile<int>(

                          title: Row(
                            children: [
                              Text(choice),
                        show_result?      index==0? choiceIndex==0 ? Icon(Icons.check , color: Colors.green,): Icon(Icons.close , color: Colors.red,):
                              index==1? choiceIndex == 1?Icon(Icons.check , color: Colors.green,): Icon(Icons.close , color: Colors.red,):
                            choiceIndex==2?Icon(Icons.check , color: Colors.green,): Icon(Icons.close , color: Colors.red,):Container()
                            ],
                          ),
                          value: choiceIndex,
                          groupValue: question.selectedChoice,
                          onChanged: (int? value) {
                            setState(() {
                              question.selectedChoice = value!;
                           if(index == 0 &&value == 0 ){     
                              result1=value;
                           }
                           else{result1 == -1;}
                           if(index == 1 &&value == 1 ){     
                              result2 = value;
                           }
                              else{result2 == -1;}
                           if(index == 2 &&value == 2 ){     
                              result3=value;
                           }
                              else{result3 == -1;}
                            });
                          },
  
                        );
                      }).toList(),
                    ),
                  ],
                ),
                );
          },
        );
              }
            )
          
          ),
  
  BlocBuilder<AuthunticationBloc, Authuntication>(
                
                    builder: (context, blocObject){
  return
  
    TextButton(onPressed: ()async{
      int score =0;
  
  if (result1 == 0)
  {score++;}
  
  if(result2 == 1)
  {score++;}
  
  if(result3== 2)
  {score++;}
  
  
  
  
  FirebaseFirestore.instance.collection('scores').doc(blocObject.usid
  ).set({
    'score': score,
    'name': blocObject.name,
  });

    var deviceState = await OneSignal.shared.getDeviceState();

    if (deviceState == null || deviceState.userId == null)
        {return;}
else{

    var playerId = deviceState.userId!;
  OneSignal.shared.postNotification(OSCreateNotification(
  playerIds: [playerId],
  content:"New Score : " +score.toString(),
  heading:"New player : " + blocObject.name,
));}

  
  
  setState(() {
    show_result= true;
  });
  

  
  
  
  
  
    }, child: Text('Send'));
  
                    }),

    
    ]),
  ),


leaderboard()

])


    );
  }
  



}



