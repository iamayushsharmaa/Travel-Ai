import 'package:flutter/material.dart';
import 'package:triptide/screens/auth/signup_page.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          const CenterText(),
          const Spacer(flex: 2),
          GetStartedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}

class CenterText extends StatelessWidget {
  const CenterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Go plan with TripTide!',
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GetStartedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Get Started',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
