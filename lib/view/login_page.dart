import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_frenzyy/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:fit_frenzyy/components/cusTextfield.dart';
import 'package:fit_frenzyy/components/cusButton.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  // Controllers:
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  //signin
  void doSignin()async{
    // Loader
    showDialog(context: context, builder: (context){
      return Center(
        child: CircularProgressIndicator(),
      );
    },);
    
    
 try{
   await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: emailController.text,
       password: passwordController.text);
   Navigator.pop(context);

 } on FirebaseAuthException catch(e){
   Navigator.pop(context);
   genericErrorMessage(e.code);
 }
  }

  void genericErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 40,),
              Image.asset(
                "lib/images/1.png",
                width: 320,
              ),
              const SizedBox(height: 1,),
              Image.asset(
                "lib/images/welcomeillus.png",
               height: 300,
              ),
              // end of logo
              const SizedBox(height: 2),
              // Username text field
              MyTextField(controller: emailController, hintText: "Email", obscureText: false),
              const SizedBox(height: 20),
              MyTextField(controller: passwordController, hintText: "Password", obscureText: true),
              const SizedBox(height: 30),
              MyButton(onTap: doSignin, text: "Signin"),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an Account?"),
                  SizedBox(width: 4,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(
                            onTap: () {},
                          ),
                        ),
                      );
                    },
                    child: Text("Register Now!",
                    style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),),
                  )
                ],
              )

            ],),
          ),
        ),
      ),

    );
  }
}
