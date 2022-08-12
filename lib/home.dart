import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'menu.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:toggle_switch/toggle_switch.dart';

final InAppReview inAppReview = InAppReview.instance;

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isiEmail = ModalRoute.of(context)!.settings.arguments.toString();

    //Membuat tampilan
    Menu m1;
    m1 = Menu(); //cara bacanya?
    m1.judul = "GoCar";
    m1.warna = Colors.blue;
    m1.icon = Icons.local_taxi;

    Menu m2 = Menu();
    m2.judul = "GoBike";
    m2.warna = Colors.green;
    m2.icon = Icons.motorcycle;

    Menu m3 = Menu();
    m3.judul = "GoFood";
    m3.warna = Colors.red;
    m3.icon = Icons.fastfood_outlined;

    Menu m4 = Menu();
    m4.judul = "GoSend";
    m4.warna = Colors.purple;
    m4.icon = Icons.send_sharp;

    Menu m5 = Menu();
    m5.judul = "GoMart";
    m5.warna = Colors.orange;
    m5.icon = Icons.store;

    Menu m6 = Menu();
    m6.judul = "GoPulsa";
    m6.warna = Colors.yellow;
    m6.icon = Icons.attach_money;

    Menu m7 = Menu();
    m7.judul = "GoFitness";
    m7.warna = Colors.pink;
    m7.icon = Icons.fitness_center;

    Menu m8 = Menu();
    m8.judul = "More";
    m8.warna = Colors.grey;
    m8.icon = Icons.more_horiz;

    List<Menu> allMenu = [];
    allMenu.add(m1);
    allMenu.add(m2);
    allMenu.add(m3);
    allMenu.add(m4);
    allMenu.add(m5);
    allMenu.add(m6);
    allMenu.add(m7);
    allMenu.add(m8);

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            //GridView = membuat tampilan multi column (kolom2)
            child: GridView.builder(
              //shrinkWrap = untuk mengecilkan space widget column, listview, dll yg terpakai semaksimal mungkin, agar muat untuk penempatan widget lain
              shrinkWrap: true,
              itemCount: allMenu.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Icon(allMenu[index].icon, color: allMenu[index].warna),
                    Text(allMenu[index].judul),
                  ],
                );
              },
            ),
          ),
          const Divider(
            height: 300,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Your Orders:",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ToggleSwitch(
                  minWidth: 90.0,
                  minHeight: 45.0,
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  labels: const ['History', 'Ongoing', 'Schedule'],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                // onPressed: () async {
                //   if (await inAppReview.isAvailable()) {
                //     inAppReview.requestReview();
                //   };
                // },
                onPressed: () {
                  inAppReview.requestReview();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Rate Us!"),
                    Icon(Icons.star),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      appBar: AppBar(
        title: const Center(child: Text("Home")),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.yellow, Colors.blue.shade300, Colors.blue],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("image/logo.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(isiEmail),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text("About"),
              subtitle: const Text("Who created this?"),
              leading: const Icon(Icons.person),
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Created by Warizmi",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }, // tampilkan toast: "created by warizmi"
            ),
            ListTile(
              title: const Text("Maps"),
              leading: const Icon(Icons.map),
              onTap: () {
                Navigator.pushNamed(context, "page_map");
              }, // pindah ke MapWidget menggunakan navigator
            ),
            ListTile(
              title: const Text("Search Universities"),
              leading: const Icon(Icons.search),
              onTap: () {
                Navigator.pushNamed(context, "page_universities");
              },
            ),
            ListTile(
              title: const Text("List of Indonesia Provinces"),
              leading: const Icon(Icons.landscape),
              onTap: () {
                Navigator.pushNamed(context, "page_provinces");
              },
            ),
            ListTile(
              title: const Text("Movie List"),
              leading: const Icon(Icons.movie),
              onTap: () {
                Navigator.pushNamed(context, "page_movie");
              },
            ),
            ListTile(
              title: const Text("Movie Booked (Firebase Database)"),
              leading: const Icon(Icons.calendar_view_month),
              onTap: () {
                Navigator.pushNamed(context, "page_movie_booked");
              },
            ),
            ListTile(
              title: const Text("Holidays in Indonesia"),
              leading: const Icon(Icons.holiday_village),
              onTap: () {
                Navigator.pushNamed(context, "page_holiday");
              },
            ),
            ListTile(
              title: const Text("Firebase Login Test"),
              leading: const Icon(Icons.login),
              onTap: () {
                Navigator.pushNamed(context, "page_fblogin");
              },
            ),
            ListTile(
              title: const Text("Firebase Cloud Messaging Test"),
              leading: const Icon(Icons.login),
              onTap: () {
                Navigator.pushNamed(context, "page_fbmessage");
              },
            ),
            const Divider(),
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.logout),
              onTap: () {
                Navigator.pushReplacementNamed(context, "page_login");
              },
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushNamed(context, "page_home");
            //   },
            //   child: Row(
            //     children: [
            //       Icon(Icons.home),
            //       Text("Home"),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
