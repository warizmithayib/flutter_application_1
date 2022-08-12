import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  //const LoginWidget({Key? key}) : super(key: key);
  var f = GlobalKey<FormState>();
  //define variabel global utk menyimpan validasi
  var t1 = TextEditingController();
  //define variabel untuk menyimpan email

  @override
  void initState() {
    super.initState();
    //inisialisasi FlutterNativeSplash jika diaktifkan di main
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        elevation: 20,
        /*bikin icon di posisi actions (kanan atas)*/
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.question_answer),
          ),
          Padding(
            padding: EdgeInsets.only(right: 100),
            child: Icon(Icons.chat_bubble),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          //untuk menggunakan 'validator' pada textformfield
          key: f,
          //menggunakan variabel global "f" ke dalam Form
          autovalidateMode: AutovalidateMode.disabled,
          //untuk validasi otomatis tanpa tekan submit .always, untuk mematikan ganti dengan .disabled
          child: ListView(
            //ListView = column yang outputnya bisa di scroll
            //scrollDirection: Axis.vertical,
            children: [
              // Image.asset(
              //   "image/logo.jpg",
              //   height: 150,
              // ),
              Image.network(
                "https://st2.depositphotos.com/3905143/6258/v/950/depositphotos_62589313-stock-illustration-login-icon-glossy-button.jpg",
                height: 150,
              ),
              TextFormField(
                controller: t1,
                autofocus: false,
                //inisialisasi input teks tanpa klik ke teks
                maxLength: 30,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return "Please input your email";
                //   } else if (value.length < 5) {
                //     return "Email min. 5 characters";
                //     //} else if (value.contains("@") == false) {
                //     //  return "Invalid email format";
                //   } else if (EmailValidator.validate(value) == false) {
                //     //https://pub.dev/packages/email_validator
                //     return "Invalid email format";
                //   } else {
                //     return null;
                //   }
                // },
                keyboardType: TextInputType.emailAddress,
                //keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: const TextStyle(color: Colors.blue),
                    hintText: "Your valid email",
                    hintStyle: const TextStyle(color: Colors.green),
                    helperText: "Please enter your valid email",
                    helperStyle: const TextStyle(color: Colors.red),
                    //counterText: "",
                    counterStyle: TextStyle(color: Colors.green[900]),
                    suffixIcon: const Icon(Icons.email),
                    prefixIcon: const Icon(Icons.email),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Color(0xffd4c906), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                        ))),
              ),
              TextFormField(
                // validator: (password) {
                //   if (password!.isEmpty) {
                //     return "Please insert your password";
                //   } else if (password.length < 3) {
                //     return "Password min. 3 characters";
                //   } else {
                //     return null;
                //   }
                // },
                maxLength: 30,
                obscureText: true,
                //menutup tampilan ketikan
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.red),
                    hintText: "Your valid password",
                    hintStyle: const TextStyle(color: Colors.green),
                    helperText: "Please enter your valid password",
                    helperStyle: const TextStyle(color: Colors.red),
                    prefixIcon: const Icon(Icons.lock),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Color(0xffd4c906), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                        ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (f.currentState?.validate() == true) {
                          Fluttertoast.showToast(
                              msg: "Login Success",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);

                          var email = t1.text;
                          Navigator.pushReplacementNamed(context, "page_home",
                              arguments: email);
                        }
                      },
                      child: const Text("Submit")),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "page_register");
                  },
                  child: const Text("Register here"),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
