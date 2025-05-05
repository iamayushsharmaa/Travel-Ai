import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Go Plan Your Trip",
            style: TextStyle(
              fontSize: 20,
              color: Colors.blueAccent
            ),
          ),
          GetStartedButton(onPressed: () => ,)
        ],
      ),
    );
  }
}
class GetStartedButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GetStartedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(

    );
  }
}



