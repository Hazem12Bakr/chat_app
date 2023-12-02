import 'package:flutter/material.dart';
import 'package:tunes_player_app/screens/register.dart';
import 'package:tunes_player_app/screens/sign_in.dart';


class WelcomeScreen extends StatelessWidget {
  static const String screenRoute = 'welcome_screen';
  const WelcomeScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Image.asset(
                'images/home_bage.jpg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7D32),
                  fixedSize: const Size(400, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, SignIn.screenRoute);
                },
                child: const Text('Sign In'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:const  Color(0xFF52ABFF),
                  fixedSize:const  Size(400, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Register.screenRoute);
                },
                child: const Text('Register'),
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}