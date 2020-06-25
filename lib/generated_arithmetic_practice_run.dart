

import 'package:flashquizv2/simple_arithmetic_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'arithmetic_card_display.dart';
import 'homepage.dart';


class GeneratedPracticeRun extends StatefulWidget {
  final deckName;
  final numDigits;
  final operatorType;
  final cardCount;

  GeneratedPracticeRun(this.deckName,{this.numDigits = DigitCount.one, this.operatorType = Operator.add, this.cardCount = 32});

  @override
  _GeneratedPracticeRunState createState() => _GeneratedPracticeRunState();
}

class _GeneratedPracticeRunState extends State<GeneratedPracticeRun> with TickerProviderStateMixin{

  AnimationController _animationController;
  AnimationController _animationController2;
  Animation _animation;
  Animation _animation2;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  Duration flipDuration = Duration(milliseconds: 500);

  List<String> questions = List<String>();
  List<String> answers = List<String>();
  int index = 0;
  bool showAnswer = false;
  Widget card;
  @override
  void initState(){
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: flipDuration);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener((){
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });
    generateDeck(widget.operatorType);
  }
  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget card = _selectCard(index);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage()
              )
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blueGrey,
              child: Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(math.pi * _animation.value),
                child: card,
              ),
            ),
            buttonBox()
          ],
        ),
      ),
    );
  }

  Widget buttonBox(){
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  '${index + 1} of ${widget.cardCount}',
                  textAlign: TextAlign.center,),
              ),
              Expanded(
                flex: 1,
                child: Text(''),
              ),
              Expanded(
                flex: 1,
                child: ButtonTheme(
                  padding: EdgeInsets.all(3.0),
                  child: FlatButton(
                    child: Text(
                        'Flip'
                    ),
                    onPressed: (){
                      if (_animationStatus == AnimationStatus.dismissed){
                        _animationController.forward();
                      }
                      else{
                        _animationController.reverse();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ButtonTheme(
                  padding: EdgeInsets.all(3),
                  child: FlatButton(
                    child: Text('Last'),
                    onPressed: () async{
                      if (_animationStatus == AnimationStatus.completed){
                        await _animationController.reverse();
                      }
                      setState(() {
                        index = index < 1 ? widget.cardCount -1 : index -1;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  padding: EdgeInsets.all(3),
                  child: FlatButton(
                    child: Text('Reset'),
                    onPressed: () async {
                      if (_animationStatus == AnimationStatus.completed){
                        await _animationController.reverse();
                      }
                      setState(()  {
                        index = 0;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  padding: EdgeInsets.all(3),
                  child: FlatButton(
                    child: Text('Next'),
                    onPressed: () async {
                      if (_animationStatus == AnimationStatus.completed){
                        await _animationController.reverse();
                      }
                      setState(()  {
                        index = index < widget.cardCount -1 ? index + 1 : 0;
                      });
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  generateDeck(Operator operator){
    SimpleArithmeticGenerator generator = SimpleArithmeticGenerator(operator: operator);
    List<Map> myDeck = generator.generateDeck();

    myDeck.forEach((e){
      questions.add('${e['numbers'][0]}\n${e['symbol']}  ${e['numbers'][1]}');
      answers.add('${e['numbers'][2]}');
    });
  }
  
  _selectCard(int cardNumber){
    index = cardNumber;

    return GestureDetector(
        onTap: () {

          if (_animationStatus == AnimationStatus.dismissed){
            _animationController.forward();
          }
          else{
            _animationController.reverse();
          }
        },
        child: _animation.value <= 0.5
            ? ArithmeticCardDisplay(index + 1, questions.length, questions[index], answers[index], showAnswer)
            : Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: ArithmeticCardDisplay(index + 1, questions.length, questions[index], answers[index], !showAnswer),
        )
    );
  }

  _adjustController() async {
    if (_animationStatus == AnimationStatus.completed){
      setState(() {
        _animationController = AnimationController(vsync: this, duration: Duration(microseconds: 1));
      });
      await _animationController.reverse();
      setState(() {
        _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
      });
    }
  }
}

