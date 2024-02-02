import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ushopie_ecom/config/routes/app_route.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/auth/data/models/signin_req.dart';
import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';
import 'package:ushopie_ecom/features/auth/domain/usecase/signin_usecase.dart';
import 'package:ushopie_ecom/features/auth/presentation/providers/user_provider.dart';
import 'package:ushopie_ecom/features/auth/presentation/widges/buton_layout.dart';

class SigninForm extends StatefulWidget {
  final SigninUsecase loginUsecase;
  final Function(bool) setLogin;

  const SigninForm({Key? key, required this.loginUsecase, required this.setLogin})
      : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool checked = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  // saving to the shared prefs:

  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  // save the user profile prefs:

  Future<void> _saveUserProfileToPrefs(UserProfileModel userProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_profile', json.encode(userProfile.toJson()));
  }

  // Login Form click
  void _performLogin() async {
  // Explicitly trigger form validation
  if (_formKey.currentState!.validate()) {
    try {
      widget.setLogin(true);

      final request = SigninRequestModel(
        email: emailController.text,
        password: passwordController.text,
      );

      final loginResult = await widget.loginUsecase.signinUser(request);

      if (loginResult.status == "success") {
        // Save login status
        await _saveLoginStatus(true);

        // Save user profile
        await UserPreferences.saveUserProfile(loginResult.userProfile!);

        _showToast("Login success");
        Navigator.pushNamed(context, AppRoute.home);
      } else {
        _showToast("Error signing in. Please retry");
      }
    } catch (e) {
      if (e is DioException) {
        _showToast("Error logging in");
      }
    } finally {
      widget.setLogin(false);
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Assign the key to the Form widget
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
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
          const SizedBox(height: 23,),
          Center(
            child: SizedBox(
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
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
          const SizedBox(height: 14,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: checked,
                    onChanged: (val) {
                      setState(() {
                        checked = val!;
                      });
                    },
                  ),
                  const Text(
                    "Remember me",
                    style: TextStyle(
                      color: colorSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const Text(
                "Forgot Password?",
                style: TextStyle(
                  color: colorError,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 52,),
          ButtonSigninSignup(
            onTap: _performLogin,
            message: "Sign In",
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}

