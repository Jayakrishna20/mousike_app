import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mousike_app/pages/home_page.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({Key? key}) : super(key: key);

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phonenoTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailTextController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _phonenoTextController,
              maxLength: 10,
              decoration: const InputDecoration(hintText: 'Phone No'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordTextController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Confirm Password'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                try {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  )
                      .then((value) {
                    sendDetails(
                        email: _emailTextController.text,
                        phoneno: _phonenoTextController.text);
                    print('Created New Account');
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
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              label: const Text(
                'Create Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
      ),
    );
  }

  Future sendDetails({required String email, required String phoneno}) async {
    final db = FirebaseFirestore.instance;
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "username": email,
      "Phone no": phoneno,
      "Created DateTime": DateTime.now()
    };

// Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}
