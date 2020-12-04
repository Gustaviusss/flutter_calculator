import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import './buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '' ;
  var userAnswer = '' ;
  final textStyle = TextStyle(fontSize: 32);

  final List<String> buttons = [
    'C',
    'Del',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '=',
  ];

   bool isOperator(String x){
    if(
      x=='%'||
      x=='/'||
      x=='x'||
      x=='-'||
      x=='+'||
      x=='='
    ){
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    
    ContextModel contextModel = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, contextModel);
    
    userAnswer = eval.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 30,),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(userQuestion, style: textStyle,)),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer, style:TextStyle(fontSize: 40),)),
                ]),
            )),
          Expanded(
              flex: 3,
              child: Container(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index){
                    if(index == 0){
                      return Buttons(
                      Colors.green,
                      buttons[index],
                      Colors.white,
                      (){
                        setState(() {
                          userQuestion = '';
                          userAnswer = '';
                        });
                      }
                      );
                    } else if(index == 1){
                      return Buttons(
                      Colors.red,
                      buttons[index],
                      Colors.white,
                      (){
                        setState(() {
                          userQuestion = userQuestion.substring(0, userQuestion.length-1);
                        });
                      }
                      );
                    }
                    //equal button
                    else if(index == buttons.length - 1){
                      return Buttons(
                      Colors.deepPurple,
                      buttons[index],
                      Colors.white,
                      (){
                        setState(() {
                        equalPressed();
                        });
                      }
                      );
                    }
                    
                    
                    
                    else{
                      return Buttons(
                      isOperator(buttons[index]) ? Colors.deepPurple: Colors.deepPurple[50],
                      buttons[index],
                      isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                      (){
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      }
                      );
                    }
                  }
                )
              )),
        ],
      ),
    );
  }
}
