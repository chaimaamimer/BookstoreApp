import 'package:bazar_app/signIn_signUp/signIn_page.dart';
import 'package:bazar_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Onboarding4 extends StatelessWidget {
  const Onboarding4({super.key});

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
              MaterialPageRoute(builder: (context) => const SigninPage()),
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
                  'assets/images/onboarding4.png',
                  width: 320,
                  height: 320,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16,),
                Center(
                  child: Text(
                    'Start Your Adventure',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey[900],
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                Center(
                  child: Text(' Ready to embark on a quest for\n inspiration and knowledge? Your\n adventure begins now. Let\'s go!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.grey[500],
                    fontSize: 16,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                  )),
                ),
                const SizedBox(height: 32,),
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //dot
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
            const SizedBox(width: 6),
                Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.primary[500],
              shape: BoxShape.circle,
            ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // get started button
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
                  backgroundColor: AppColors.primary[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Get Started',
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
      )
    );
  }
}
