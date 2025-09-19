
import 'package:bazar_app/home_page.dart';
import 'package:bazar_app/main_page.dart';
import 'package:bazar_app/signIn_signUp/auth_service.dart';
import 'package:bazar_app/signIn_signUp/signup_page.dart';
import 'package:bazar_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  //get auth service
  final authService = AuthService();
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true; 

  //login button pressed
  void login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final response =
          await authService.signInWithPassword(email: email, password: password);
    } catch (e) {
      //show error message
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar( 
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text.rich(
                TextSpan(
                  text: 'Welcome back ',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'OpenSans'),
                  children: [
                    WidgetSpan(
                      child: Text('👋', style: TextStyle(fontSize: 22)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Sign to your account',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 15,
              ),
              Text("Email",style: TextStyle(color: Colors.grey[900],fontFamily: 'Roboto',fontWeight: FontWeight.bold, fontSize: 14),),
              // email textfield
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.grey[50],
                  hintText: 'Your email',
                  hintStyle: TextStyle(color: Colors.grey[400],fontFamily: 'Roboto',fontWeight: FontWeight.w400, fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height:8),
              //password textfield
              Text("Password",style: TextStyle(color: Colors.grey[900],fontFamily: 'Roboto',fontWeight: FontWeight.bold, fontSize: 14),),
              TextField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.grey[50],
                  hintText: 'Your password',
                  hintStyle: TextStyle(color: Colors.grey[400],fontFamily: 'Roboto',fontWeight: FontWeight.w400, fontSize: 16),
                  suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),const SizedBox(height: 16,),
              //forgot password button
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    //forgot password logic
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: AppColors.primary[500],
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height:10),
              //login button
Center(
  child: SizedBox(
    width: 327,
    height: 48,
    child: ElevatedButton(
      onPressed: () async {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        if (email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please fill in all fields")),
          );
          return;
        }
        try {
          await authService.signInWithPassword(
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
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary[500],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
      ),
      child: const Text(
        'Login',
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

            const SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?', style: TextStyle(color: AppColors.grey[700], fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 14),),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupPage()),
                    );
                    //navigate to sign up page
                  },
                  child: Text('Sign Up', style: TextStyle(color: AppColors.primary[500], fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 14),),
                ),
              ],
            ),
            //or with
            Row(
              children: [
                Expanded(child: Divider(
                  thickness: 1,
                  color: AppColors.grey[200],
                )),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0), child: Text('Or with', style: TextStyle(color: AppColors.grey[500], fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 14),)
                ),
                Expanded(child: Divider(
                  thickness: 1,
                  color: AppColors.grey[200],
                )),
              ],
            ),
            //google sign in button
            const SizedBox(height:10),
            Center(
          child: SizedBox(
            width: 327,
            height: 48,
            child: ElevatedButton(
        onPressed: () async {
        await Supabase.instance.client.auth.signInWithOAuth(
            OAuthProvider.google,
          );
        },
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
            side: BorderSide(
              color: AppColors.grey[300]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/googlelogo.png',
            ),
            const SizedBox(width: 8),
            Text(
              'Sign in with Google',
              style: TextStyle(
                color: AppColors.grey[900],
                fontSize: 16,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
            ),
          ),
        ),//apple signin button
        const SizedBox(height:10),
            Center(
          child: SizedBox(
            width: 327,
            height: 48,
            child: ElevatedButton(
        onPressed: () async {
        await Supabase.instance.client.auth.signInWithOAuth(
            OAuthProvider.apple,
          );
        },
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
            side: BorderSide(
              color: AppColors.grey[300]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/appleicon.png',
            ),
            const SizedBox(width: 8),
            Text(
              'Sign in with Apple',
              style: TextStyle(
                color: AppColors.grey[900],
                fontSize: 16,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
            ),
          ),
        )
        
          ],
        ),
            ),
      ));
  }
}
