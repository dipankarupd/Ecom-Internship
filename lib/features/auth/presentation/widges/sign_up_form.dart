import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/routes/app_route.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/auth/data/models/signup_req.dart';
import 'package:ushopie_ecom/features/auth/domain/usecase/signup_usecase.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpForm extends StatefulWidget {
  final SignupUsecase signupUsecase;
  final Function(bool) setSigningUp;

  const SignUpForm({Key? key, required this.signupUsecase, required this.setSigningUp})
      : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String signupMessage = "";

  void _performSignup() async {
    try {
      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        setState(() {
          signupMessage = "Please fill all the fields";
        });
        return;
      }

      widget.setSigningUp(true); // Set signing up to true

      final request = SignupRequestModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      final signupResult = await widget.signupUsecase.signupUser(request);

      final isSuccess = signupResult.status == "success";

      if (isSuccess) {
        setState(() {
          signupMessage = "Signup Successful";
        });
        // navigate:
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, AppRoute.login);
        });
      } else {
        setState(() {
          signupMessage = "Failed to sign up";
        });
        _showToast(signupMessage);
      }
    } catch (e) {
      setState(() {
        signupMessage = "Error during sign up: $e";
      });
      _showToast(signupMessage);
    } finally {
      widget.setSigningUp(false); // Set signing up back to false
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  'assets/images/Frame.png',
                  width: 22,
                  height: 22,
                ),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
                labelText: "Name",
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 22,),
        Center(
          child: SizedBox(
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  'assets/images/Frame.png',
                  width: 22,
                  height: 22,
                ),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
                labelText: "Password",
                labelStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(height: 22,),
        Center(
          child: SizedBox(
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  'assets/images/Frame.png',
                  width: 22,
                  height: 22,
                ),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
                labelText: "Email",
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 51,),
        GestureDetector(
          onTap: _performSignup,
          child: Container(
            padding: const EdgeInsets.fromLTRB(97, 18, 97, 18),
            decoration: BoxDecoration(
              color: colorSecondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30,),
      ],
    );
  }
}
