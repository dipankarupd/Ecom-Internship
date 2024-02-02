import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/routes/app_route.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

 

  @override
  Widget build(BuildContext context) {
    
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorSecondary,
        image: DecorationImage(
          image: const NetworkImage('https://images.pexels.com/photos/4028816/pexels-photo-4028816.jpeg?auto=compress&cs=tinysrgb&w=800' ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(colorSecondary.withOpacity(0.4), BlendMode.dstATop)
        )
      ),
      child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 201,),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                "Get Your Favourite Items in One Place",
                style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 50),
                ),
            ),



            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 184),
                width: 312,
                alignment: Alignment.center,
                child: ElevatedButton(
                   
                    onPressed: () => Navigator.pushNamed(context, AppRoute.login) ,
                    child: const Text(
                      "Get Started", 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      ) 
                    ),
              ),
            ),

          ]
      ),
    );
  }
}