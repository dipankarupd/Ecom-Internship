import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/auth/domain/usecase/signup_usecase.dart';
import 'package:ushopie_ecom/features/auth/presentation/widges/buton_layout.dart';
import 'package:ushopie_ecom/features/auth/presentation/widges/sign_up_form.dart';
import 'package:ushopie_ecom/features/util/widges/app_logo.dart';

class SignUpPage extends StatefulWidget {
  final SignupUsecase signupUsecase;

  const SignUpPage({required this.signupUsecase, Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isSigningUp = false;

  void _setSigningUp(bool value) {
    setState(() {
      isSigningUp = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 75, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // header
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLogo(fontsize: 21),
                      SizedBox(height: 41.83,),
                      Text("Hi", style: TextStyle(color: colorSecondary, fontSize: 40, fontWeight: FontWeight.bold),),
                      SizedBox(height: 6,),
                      Text("Sign up to continue", style: TextStyle(color: Color(0xff544e64), fontSize: 16),),
                      SizedBox(height: 50,),
                    ],
                  ),

                  SignUpForm(
                    signupUsecase: widget.signupUsecase,
                    setSigningUp: _setSigningUp,
                  ),

                  const Center(
                    child: Text("OR"),
                  ),

                  // Divider
                  const Center(
                    child: SizedBox(
                      width: 80,
                      child: Divider(color: Colors.black, thickness: 0.6,),
                    ),
                  ),

                  const SizedBox(height: 26.5,),

                  // Footer
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                        child: ButtonGoogleFacebook(
                          title: "Google",
                          url: "assets/images/google.png",
                        ),
                      ),
                      const SizedBox(height: 18,),
                      const Center(
                        child: ButtonGoogleFacebook(
                          title: "Facebook",
                          url: "assets/images/fb.png",
                        ),
                      ),
                      const SizedBox(height: 24,),
                      Center(
                        child: RichText(
                          text:  TextSpan(
                            children: [
                              const TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                              TextSpan(
                                text: "Login",
                                style: const TextStyle(color: Colors.orange, fontSize: 14),
                                recognizer: TapGestureRecognizer()..onTap = () => Navigator.of(context).pop()
                                // recognizer: TapGestureRecognizer()..onTap = ()=> Navigator.push...
                              ),
                              const TextSpan(
                                text: " here",
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          if (isSigningUp)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
