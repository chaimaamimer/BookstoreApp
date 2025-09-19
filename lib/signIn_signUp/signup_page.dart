import 'package:bazar_app/home_page.dart';
import 'package:bazar_app/main_page.dart';
import 'package:bazar_app/signIn_signUp/auth_service.dart';
import 'package:bazar_app/signIn_signUp/signIn_page.dart';
import 'package:bazar_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final authService = AuthService();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hasMinLength = false;
  bool hasNumber = false;
  bool hasLetter = false;
  bool _showConditions = false;

  @override
  void initState() {
    super.initState();
    _passwordFocus.addListener(() {
      setState(() {
        _showConditions = _passwordFocus.hasFocus;
      });
    });
  }

  @override
  //register button pressed
  void signUp() async {
  final email = emailController.text;
  final password = _passwordController.text; 

  try {
    final response = await authService.signUpWithPassword(
      email: email,
      password: password,
    );

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}

  void dispose() {
    _passwordController.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _validatePassword(String password) {
    setState(() {
      hasMinLength = password.length >= 8;
      hasNumber = RegExp(r'[0-9]').hasMatch(password);
      hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    });
  }

  Widget _buildCondition(bool condition, String text) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check : Icons.close,
          color: condition ? AppColors.primary[500]! : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: AppColors.grey[500],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  bool get _isPasswordValid => hasMinLength && hasNumber && hasLetter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sign Up",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey[900],
                      fontFamily: 'OpenSans')),
              const SizedBox(height: 8),
              Text("Create an account and choose favorite menu",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.grey[500],
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 24),
              // NAME textfield
              Text("Name",
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
              TextField(
                decoration: InputDecoration(
                  hintText: "Your name",
                  hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 8),
              // EMAIL textfield
              Text("Email",
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Your email",
                  hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 8),
              // PASSWORD textfield
              Text("Password",
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
              TextField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                obscureText: true,
                onChanged: _validatePassword,
                decoration: InputDecoration(
                  hintText: "Your password",
                  hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none),
                ),
              ),
              // Password conditions (shown only when focus or writing)
              if (_showConditions) ...[
                const SizedBox(height: 8),
                _buildCondition(hasMinLength, "Minimum 8 characters"),
                _buildCondition(hasNumber, "At least 1 number (0-9)"),
                _buildCondition(
                    hasLetter, "At least lowercase or uppercase letters"),
              ],
              const SizedBox(height: 24),
              // REGISTER BUTTON
              Center(
                child: SizedBox(
                  width: 327,
                  height: 48,
                  child: ElevatedButton(
                  onPressed: () async {
                  if (_isPasswordValid) {
                    signUp(); 
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please complete password conditions")),
                    );
                  }
                  },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary[500], 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        child: const Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

                ),
              ),
              const SizedBox(height: 24),
              // Sign in button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account? ",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 14)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SigninPage()));
                    },
                    child: Text("Sign In",
                        style: TextStyle(
                            color: AppColors.primary[500],
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Terms and policy
              Center(
                child: Text("By clicking Register , you agree to our ",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 12)),
              ),
              Center(
                child: Text("Terms and Data Policy.",
                    style: TextStyle(
                        color: AppColors.primary[500],
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
