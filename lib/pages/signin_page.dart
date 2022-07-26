import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mousike_app/pages/home_page.dart';
import 'package:mousike_app/pages/signup_page.dart';

class ScreenSignIn extends StatefulWidget {
  const ScreenSignIn({Key? key}) : super(key: key);

  @override
  State<ScreenSignIn> createState() => _ScreenSignInState();
}

class _ScreenSignInState extends State<ScreenSignIn> {
  final _emailTextController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('MOUSIKE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            const Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailTextController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                  email: _emailTextController.text,
                  password: _passwordController.text,
                )
                    .then((value) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const HomePage();
                      },
                    ),
                  );
                }).onError((error, stackTrace) {
                  print('Error ${error.toString()}');
                });
              },
              child: const Text('SIGN IN'),
            ),
            const SizedBox(height: 10),
            signUpOption(),
            //forgetPassword(context),
          ],
        ),
      )),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?", style: TextStyle(color: Colors.blue)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ScreenSignUp()));
          },
          child: const Text(
            "  Sign Up",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  // Widget forgetPassword(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: 35,
  //     alignment: Alignment.center,
  //     child: TextButton(
  //       child: const Text(
  //         "Forgot Password?",
  //         style: TextStyle(color: Colors.black),
  //         textAlign: TextAlign.right,
  //       ),
  //       onPressed: () =>
  //           Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword())),
  //     ),
  //   );
  // }
}
