import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/covid19.dart';
import 'package:flutter_application_1/fb_message.dart';
import 'package:flutter_application_1/holiday.dart';
import 'package:flutter_application_1/movie_booked.dart';
import 'package:flutter_application_1/movie_detail.dart';
import 'package:flutter_application_1/searchresult.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'home.dart';
import 'login.dart';
import 'register.dart';
import 'map.dart';
import 'universities.dart';
import 'provinces.dart';
import 'movie.dart';
import 'movie_detail.dart';
import 'movie_booked.dart';
import 'holiday.dart';
import 'fb_login.dart';
import 'fb_message.dart';
import 'login2.dart';

void main() async {
  //inisialisasi saat aplikasi flutter ingin akses hardware
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //inisialisasi FlutterNativeSplash untuk login.dart
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  await Hive.openBox("favorite_movie");
  //inisialisasi untuk fitur book movie dan firebase auth login
  await Firebase.initializeApp();

  runApp(
    OverlaySupport(
      child: MaterialApp(
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          // scaffoldBackgroundColor: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(
            ThemeData.light()
                .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          ),
        ),
        home: LoginWidget(),
        routes: {
          "page_register": (context) => const RegisterWidget(),
          "page_home": (context) => const HomeWidget(),
          "page_login": (context) => LoginWidget(),
          "page_map": (context) => const MapWidget(),
          "page_universities": (context) => const UniversitiesWidget(),
          "page_provinces": (context) => const ProvincesWidget(),
          "page_movie": (context) => const MovieWidget(),
          "page_movie_detail": (context) => const MovieDetailWidget(),
          "page_movie_booked": (context) => const MovieBookedWidget(),
          "page_result": (context) => const SearchResultWidget(),
          "page_holiday": (context) => const HolidayWidget(),
          "page_fblogin": (context) => FBLoginWidget(),
          "page_fbmessage": (context) => const FBMessageWidget(),
          "page_covid19": (context) => Covid19Widget(),
        },
      ),
    ),
  );
}

/* Default template untuk StatelessWidget = ketik stl - auto */
class HomeWidget2 extends StatelessWidget {
  const HomeWidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Aplikasinya
      home: Scaffold(
        //Halamannya
        appBar: AppBar(
          //Isi halamannya terdapat widget appbar
          title: const Text(
            "Flutter Course",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              letterSpacing: 2,
              fontFamily:
                  "Ayam", //custom font didaftarkan melalui file config "pubspec.yaml"
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.orange[900],
          leading: const Icon(
            //bikin icon di posisi leading (kiri atas)
            Icons.menu,
            color: Colors.blue,
            size: 24,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("image/logo.jpg"))),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("1 "),
                  Text("2 "),
                  Text("3 "),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("4 "),
                  Text("5 "),
                  Text("6 "),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("7 "),
                  Text("8 "),
                  Text("9 "),
                ],
              ),
              Padding(
                //padding: const EdgeInsets.all(8.0),
                //padding: EdgeInsets.fromLTRB(10, 20, 30, 40),
                padding: const EdgeInsets.only(bottom: 15, top: 20),
                //padding: EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: const Text("Submit Elevated")),
              ),
              TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.blue))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check),
                      Text("Submit Text"),
                    ],
                  )),
              SizedBox(
                height: 100,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("Submit Outlined"),
                ),
              ),
              const SizedBox(
                //Dipakai untuk mengatur ukuran widget lain
                height: 50,
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.check)),
              const Divider(
                height: 1,
                color: Colors.red,
                thickness: 5,
              ),
              TextFormField(),
              const CircularProgressIndicator(),
              const LinearProgressIndicator(),
              const FlutterLogo(),
              Image.asset("image/logo.jpg"),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tombol ditekan berapa kali?',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
