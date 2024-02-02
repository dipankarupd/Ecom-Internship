import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/routes/app_route.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/auth/domain/usecase/signin_usecase.dart';
import 'package:ushopie_ecom/features/auth/presentation/widges/buton_layout.dart';
import 'package:ushopie_ecom/features/auth/presentation/widges/signin_form.dart';
import 'package:ushopie_ecom/features/util/widges/app_logo.dart';

class LoginPage extends StatefulWidget {

  final SigninUsecase loginUsecase;

  const LoginPage({super.key, required this.loginUsecase});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool islogging = false;

  _setLogin(bool value) {
    setState(() {
      islogging = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Stack(
        children:[
            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 75, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
                  // header:
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLogo(fontsize: 21,),
            
                      SizedBox(height: 41.83,),
            
                      Text(
                        "Welcome!", 
                        style: TextStyle(
                          color: colorSecondary, 
                          fontSize: 40, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
            
                      SizedBox(height: 6,),
            
                      Text(
                        "Sign in to continue", 
                        style:  TextStyle(
                          color: Color(0xff544e64),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 85,)
                    ],
                  ),
            
            
                  // Form:
            
                  SigninForm(
                    loginUsecase: widget.loginUsecase,
                    setLogin: _setLogin,
                  ),
            
                  const Center(
                      child: Text("OR"),
                    ),
            
                    // Divider
            
                  Center(
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: 80,
                      child: const Divider(color: Colors.black, thickness: 0.6,),
                    ),
                  ),
            
                  const SizedBox(height: 26.5,),
            
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: ButtonGoogleFacebook(
                        title: "Google",
                        url: "assets/images/google.png", 
                      )),
                      SizedBox(height: 18,),
                      Center(child: const ButtonGoogleFacebook(
                        title: "Facebook",
                        url: "assets/images/fb.png"
                      )),
                      SizedBox(height: 24,),
                    ],
                  ),
            
                  Center(
                          child: RichText(
                            text:  TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(color: Colors.black, fontSize: 14)
                                ), 
                                TextSpan(
                                  text: "Sign Up", 
                                  style: const TextStyle(color: Colors.orange, fontSize: 14),
                                  recognizer: TapGestureRecognizer()..onTap = ()=> Navigator.pushNamed(context, AppRoute.signup)
                                    
                                  
                                ),
                                const TextSpan(
                                  text: " here", 
                                  style: TextStyle(color: Colors.black, fontSize: 14),
                                )
                              ]
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
          if (islogging)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(child: CircularProgressIndicator(),),
            )
        ]
      ),

      
    );
    
  }
}
