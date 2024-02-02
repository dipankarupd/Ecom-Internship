
import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';

// ignore: must_be_immutable
class ButtonSigninSignup extends StatelessWidget {

  final Function()? onTap;
  String message;
  
   ButtonSigninSignup({super.key, required this.onTap, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
                      padding: const EdgeInsets.fromLTRB(97, 18, 97, 18),
                      decoration: BoxDecoration(
                        color: colorSecondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:  Center(
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
      
                    ),
    );
  }
}

class ButtonGoogleFacebook extends StatelessWidget {
  final String title;
  final String url;
  const ButtonGoogleFacebook({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
                      width: 216,
                      height: 48,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.1 ),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Row(
                        children: [
                          Image.asset(
                            url, 
                            width: 24,
                            height: 24,
                          ),

                          const SizedBox(width: 14,),
                           Center(
                            child: Text("Sign up with $title", style: const TextStyle(fontSize: 14),),
                          )
                        ],
                      ),
                    ) ;
  }
}