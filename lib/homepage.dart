

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'generated_arithmetic_practice_run.dart';
import 'simple_arithmetic_generator.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final Color buttonColor = Colors.blue;

  @override
  Widget build(BuildContext context) {

    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    double buttonWidth = phoneWidth / 3;
    double buttonHeight = phoneHeight / 12;
    double spacerHeight = phoneHeight/ 6;

    TextStyle buttonText = TextStyle(
      fontSize: 18.0,
      color: Colors.white,
    );
    TextStyle textStyle = TextStyle(
      fontSize: 18.0,
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.italic,
    );
    Widget welcomeSection = Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              'Welcome to FlashQuiz',
              style: TextStyle(
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'images/addition_flashcards.gif',
              width: phoneWidth,
              height: phoneWidth * 0.7,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: spacerHeight,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonTheme(
                            height: buttonHeight,
                            minWidth: buttonWidth,
                            padding: EdgeInsets.all(3.0),
                            child: FlatButton(
                              child: Text(
                                'Addition',
                                textAlign: TextAlign.center,
                                style: buttonText,
                              ),
                              onPressed: () {
                                //_gotoPracticeRun(widget.deck);
                                _gotoGeneratedArithmetic(Operator.add);
                              },
                              color: buttonColor,
                            ),
                          ),
                        ],
                      )
                  ),
                  Expanded(
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonTheme(
                            height: buttonHeight,
                            minWidth: buttonWidth,
                            padding: EdgeInsets.all(3.0),
                            child: FlatButton(
                              child: Text(
                                'Subtraction',
                                textAlign: TextAlign.center,
                                style: buttonText,
                              ),
                              onPressed: (){
                                _gotoGeneratedArithmetic(Operator.subtract);
                              },
                              color: buttonColor,
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonTheme(
                            height: buttonHeight,
                            minWidth: buttonWidth,
                            padding: EdgeInsets.all(3.0),
                            child: FlatButton(
                              child: Text(
                                'Multiplication',
                                textAlign: TextAlign.center,
                                style: buttonText,
                              ),
                              onPressed: () {
                                //_gotoPracticeRun(widget.deck);
                                _gotoGeneratedArithmetic(Operator.multiply);
                              },
                              color: buttonColor,
                            ),
                          ),
                        ],
                      )
                  ),
                  Expanded(
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonTheme(
                            height: buttonHeight,
                            minWidth: buttonWidth,
                            padding: EdgeInsets.all(3.0),
                            child: FlatButton(
                              child: Text(
                                'Division',
                                textAlign: TextAlign.center,
                                style: buttonText,
                              ),
                              onPressed: (){
                                _gotoGeneratedArithmetic(Operator.divide);
                              },
                              color: buttonColor,
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),

          ],
        ));
    return new Scaffold(
      appBar: AppBar(
        title: Text('Flash Quiz'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){}
          )
        ],
      ),
      body: welcomeSection,
      backgroundColor: Colors.white,
    );
  }

  _gotoGeneratedArithmetic(Operator operator){
    String deckName;
    switch(operator){
      case Operator.add:
        deckName = 'Addition';
        break;
      case Operator.subtract:
        deckName = 'Subtraction';
        break;
      case Operator.multiply:
        deckName = 'Multiplication';
        break;
      case Operator.divide:
        deckName = 'Division';
        break;
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => GeneratedPracticeRun(deckName, operatorType: operator,)
    ));
  }
}