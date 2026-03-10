import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/button.dart';
import 'package:todo_app/widgets/text_field.dart';
import '../providers/auth_provider.dart';
import '../constants/app_colors.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              children: [
                SizedBox(height: height * 0.01),

                Image.asset("assets/logo.jpg", height: height * 0.18),

                SizedBox(height: height * 0.04),

                Text(
                  "Create your Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: height * 0.04),

                // Fields
                CustomTextField(controller: email, hintText: "Email"),

                SizedBox(height: height * 0.025),

                CustomTextField(
                  controller: password,
                  hintText: "Password",
                  obscureText: true,
                ),

                SizedBox(height: height * 0.025),

                CustomTextField(
                  controller: confirmPassword,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),

                SizedBox(height: height * 0.05),

                // Button
                CustomButton(
                  text: "Sign up",
                  onPressed: () async {
                    if (password.text != confirmPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    bool success = await provider.signup(
                      email.text,
                      password.text,
                    );

                    if (success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Signup Failed")),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
