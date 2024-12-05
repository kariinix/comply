import 'package:flutter/material.dart';
import './register_screen.dart';
import './login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryTextColor = const Color(0xFF5F6F52);
    Color buttonTextColor = const Color(0xFF2D2319);
    Color buttonBackgroundColor = const Color(0xFFD1B090);
    Color buttonBorderColor = buttonTextColor;
    Color complyColor = const Color(0xFFB99470);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 170),
            Image.asset(
              'assets/images/logo.png',
              height: 55,
              width: 280,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.21,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'IMPROVE\nYOUR LIFE\nWITH ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                          fontSize: 34,
                          height: 1.3,
                        ),
                      ),
                      TextSpan(
                        text: 'COMPLY',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: complyColor,
                          fontSize: 34,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 65),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: buttonTextColor,
                backgroundColor: buttonBackgroundColor,
                elevation: 4,
                shadowColor: Colors.black54,
                side: BorderSide(color: buttonBorderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                fixedSize: const Size(280, 60),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              ),
              child: const Text('Create account'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: buttonTextColor,
                backgroundColor: Colors.transparent,
                side: BorderSide(color: buttonBorderColor),
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                fixedSize: const Size(280, 60),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
