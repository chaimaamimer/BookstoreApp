import 'package:bazar_app/home_page.dart';
import 'package:bazar_app/main_page.dart';
import 'package:bazar_app/onboardings/onboarding3.dart';
import 'package:bazar_app/signIn_signUp/signIn_page.dart';
import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:"https://ndbhzpizldxveeiotcix.supabase.co" ,
    anonKey:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5kYmh6cGl6bGR4dmVlaW90Y2l4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc5ODA1MzAsImV4cCI6MjA3MzU1NjUzMH0.FckcnQ_V2DyUpOQdY1Nkgz_gdv3zH7-RpqS2mxfkaIk" ,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      final session = Supabase.instance.client.auth.currentSession;

      if (session != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnBoarding2()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primary[500],
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage('assets/icons/frame.png'),
                color: Colors.white,
                size: 30,
              ),
              SizedBox(width: 8),
              Text(
                'Bazar.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  Next Page
class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Onboarding3()),
            );
          },
          child: Text(
            "Skip",
            style: TextStyle(
              color: AppColors.primary[500],
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //image
                Image.asset(
                  'assets/images/onboarding2.png',
                  width: 320,
                  height: 320,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16,),
                Center(
                  child: Text(
                    'Now reading books\n will be easier',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey[900],
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                Center(
                  child: Text(' Discover new worlds, join a vibrant\n reading community. Start your reading adventure effortlessly with us.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.grey[500],
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  )),
                ),
                const SizedBox(height: 32,),
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //dots
                Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.primary[500],
              shape: BoxShape.circle,
            ),
                ),
                const SizedBox(width: 6), 
                Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey[200],
              shape: BoxShape.circle,
            ),
                ),
                const SizedBox(width: 6),
                Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey[200],
              shape: BoxShape.circle,
            ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // continue button
            SizedBox(
              width: 327,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Onboarding3()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            //sign in button
            SizedBox(
              width: 327,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SigninPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: AppColors.primary[500],
                    fontSize: 16,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            ],
          ),
        ),
            ),
      ));
  }
}
