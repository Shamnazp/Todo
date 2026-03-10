import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/homescreen.dart';
import 'package:todo_app/screens/signup_screen.dart';
import 'package:todo_app/widgets/button.dart';
import 'package:todo_app/widgets/text_field.dart';
import '../providers/auth_provider.dart';
import '../constants/app_colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.1),

                Image.asset("assets/logo.jpg", height: height * 0.18),

                SizedBox(height: height * 0.04),

                const Text(
                  "Login to your Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
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

                SizedBox(height: height * 0.04),

                // Button
                CustomButton(
                  text: "Sign in",
                  onPressed: () async {
                    bool success = await provider.login(
                      email.text,
                      password.text,
                    );

                    if (success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login Failed")),
                      );
                    }
                  },
                ),

                SizedBox(height: height * 0.08),

                // Bottom
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignupScreen()),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
