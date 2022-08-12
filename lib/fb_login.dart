//1
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

//2
FirebaseAuth auth = FirebaseAuth.instance;

class FBLoginWidget extends StatefulWidget {
  @override
  State<FBLoginWidget> createState() => _FBLoginWidgetState();
}

class _FBLoginWidgetState extends State<FBLoginWidget> {
  // const FBLoginWidget({Key? key}) : super(key: key);
  var f = GlobalKey<FormState>();

  final t1 = TextEditingController();
  final t2 = TextEditingController();

  var statustextInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase auth login test"),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: f,
            autovalidateMode: AutovalidateMode.disabled,
            child: ListView(
              children: [
                TextFormField(
                    controller: t1,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please input your email";
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    controller: t2,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: statustextInvisible,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          statustextInvisible = !statustextInvisible;
                          setState(() {});
                        },
                        child: const Icon(Icons.remove_red_eye),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please input your password";
                      } else {
                        return null;
                      }
                    }),
                ElevatedButton(
                    onPressed: () async {
                      if (f.currentState?.validate() == true) {
                        try {
                          String emailku = t1.text;
                          String passwordku = t2.text;
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: emailku, password: passwordku);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            Fluttertoast.showToast(
                              msg: "User not found",
                              backgroundColor: Colors.red,
                            );
                          } else if (e.code == 'wrong-password') {
                            Fluttertoast.showToast(
                              msg: "Wrong password",
                              backgroundColor: Colors.red,
                            );
                          } else {}
                        }
                        var currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser != null) {
                          Fluttertoast.showToast(
                            msg: "Login success",
                          );
                        }
                      }
                    },
                    child: const Text("Sign In")),
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Fluttertoast.showToast(
                        msg: "You are signed out",
                      );
                    },
                    child: const Text("Sign Out")),
                TextButton(onPressed: () {}, child: const Text("To Register")),
                OutlinedButton(
                    onPressed: () {
                      FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User? user) {
                        if (user == null) {
                          print('User is currently signed out!');
                        } else {
                          print('User is signed in!');
                        }
                      });
                    },
                    child: const Text("Are you signed in?")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
