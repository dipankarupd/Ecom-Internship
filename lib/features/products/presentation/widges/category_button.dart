import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {

  final String items;
  const CategoryButton({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      height: 35,
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        gradient: LinearGradient(colors: [Colors.white, const Color(0xff9168ff).withOpacity(0.5),])
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Image.asset("assets/images/category button/clothes.png"),
            ),
            
            const SizedBox(width: 8,),
             Text(
              items, 
              style: const TextStyle(
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}