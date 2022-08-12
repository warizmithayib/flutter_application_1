import 'package:flutter/material.dart';
import 'package:flutter_application_1/register.dart';

var t1 = TextEditingController();
var t2 = TextEditingController();

class Login2Widget extends StatelessWidget {
  const Login2Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 50),
// Tulisan Hello
              Row(
                children: const <Widget>[
                  Text(
                    "Hello.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Divider(
                      thickness: 3,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
              // Tulisan Welcome back
              const Text(
                "Welcome back",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 36,
                    letterSpacing: 5),
              ),
// Spasi
              const SizedBox(height: 20),
// Form username & password
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Email",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: t1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Input your email",
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: t2,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Input your password",
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {},
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: const Color(0xFF4f4f4f),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: const <Widget>[
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "OR",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {},
                  child: const Text(
                    "Login with Google",
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {},
                  child: const Text(
                    "Login with Facebook",
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 30),
            ]),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    "Don’t have account ?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterWidget()));
                    },
                    child: const Text(
                      "Register here",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
