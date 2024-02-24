import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(children: [
            const SizedBox(height: 50),
            Image.asset(
              "lib/images/1.png",
              height: 320,
              width: 320,
            ),
            // end of logo
            // Welcome text
            Text("LOGIN", style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 40),
              )
            
            ,
          ],),
        ),
      ),

    );
  }
}
