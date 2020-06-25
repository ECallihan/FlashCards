
import 'dart:math';
import 'dart:convert';
import 'package:charcode/charcode.dart';

enum Operator{add, subtract, multiply, divide}
enum DigitCount{one, two, three}

class SimpleArithmeticGenerator  {
  final deckSize;
  final operator;
  final digits;
  SimpleArithmeticGenerator({this.deckSize = 32, this.operator = Operator.add, this.digits = DigitCount.one});

  static AsciiCodec ascii = AsciiCodec();
  final divSymbol = String.fromCharCode($divide);//ascii.decode([0xF6]);

  List<Map> generateDeck(){
    List<Map> myDeck = List<Map>();
    Random random = Random();
    int maxDigitValue;

    if(digits == DigitCount.one){
      maxDigitValue = 10;
    }else if(digits == DigitCount.two){
      maxDigitValue = 100;
    }else if(digits == DigitCount.three){
      maxDigitValue = 1000;
    }
    for(int i = 0; i < deckSize; i++){
      int a = random.nextInt(maxDigitValue) + 1;
      int b = random.nextInt(maxDigitValue) + 1;
      if(operator == Operator.add){
        int c = a + b;
        myDeck.add({"numbers":[a,b,c], "symbol": "+"});
      }else if(operator == Operator.subtract){
        int c = a + b;
        myDeck.add({"numbers":[c,b,a], "symbol": "-"});
      }else if(operator == Operator.multiply){
        int c = a * b;
        myDeck.add({"numbers":[a,b,c], "symbol": "x"});
      }else if(operator == Operator.divide){
        int c = a * b;
        myDeck.add({"numbers":[c,b,a], "symbol": divSymbol});
      }

    }
    return myDeck;
  }

}
