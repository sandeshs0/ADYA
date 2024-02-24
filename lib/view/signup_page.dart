import 'package:flutter/material.dart';
import 'package:fit_frenzyy/components/cusTextfield.dart';
import 'package:fit_frenzyy/components/cusButton.dart';
import 'package:fit_frenzyy/main.dart';
import 'package:fit_frenzyy/view/login_page.dart';


class SignupPage extends StatefulWidget {
  final Function()? onTap;
  SignupPage({super.key, required this.onTap});

  @override
  State<SignupPage> createState() => _SignupPageState();
}


class _SignupPageState extends State<SignupPage> {

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,// Make the scaffold background transparent
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "lib/images/1.png",
                    width: 300,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Center(
                    child: Text(
                      "Create an Account",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //email textfield
                  SizedBox(height: 25),
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),

                  //

                  //password textfield
                  SizedBox(
                    height: 25,
                  ),
                  MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),

                  //confirm password textfield
                  SizedBox(
                    height: 25,
                  ),
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),

                  //forgot password
                  SizedBox(height: 20),

                  SizedBox(height: 20),
                  MyButton(
                    text: 'Sign in',
                    onTap: signUp,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have and account?",
                        style: TextStyle(color: MyApp.textColor, fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(
                                onTap: () {},
                              ),
                            ),
                          );
                        },
                        child: Text(
                          " Login Now",
                          style: TextStyle(color: MyApp.btnColor, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.3,
                            color: MyApp.textColor,
                          ),
                        ),
                        Text(
                          "Or Continue with",
                          style: TextStyle(color: MyApp.textColor),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.3,
                            color: MyApp.textColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "lib/image/image8-2.webp",
                        height: 100,
                        width: 120,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
