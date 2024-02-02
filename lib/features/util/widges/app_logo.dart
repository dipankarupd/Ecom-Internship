import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

// ignore: must_be_immutable
class AppLogo extends StatelessWidget {

  final double fontsize;


  const AppLogo({Key? key, this.fontsize = 40.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GradientText(
      "Ushopie", 
      style:  TextStyle(
        fontSize: fontsize,
        fontWeight: FontWeight.bold
      ),
      colors: const <Color>[
        Color(0xFFAB47BC),
        Color(0xFFFCB96B),
        Color(0xFF8161D6),
      ]);
      
  }
}