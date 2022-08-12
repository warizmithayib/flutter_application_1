//problem:
//1. pengiriman lambat. perlu set priority to high
//   atau kirim message berupa data / notif + data
//2. saat app diklik, data dlm app tidak terupdate,
//   hanya terupdate saat notifnya yang diklik.
//   perlu gunakan onBackgroundMessage
//debug:
//  D/FLTFireMsgReceiver(13502): broadcast received for message
//  W/FLTFireMsgService(13502): A background message could not be handled in Dart as no onBackgroundMessage handler has been registered.
//  W/FirebaseMessaging(13502): Missing Default Notification Channel metadata in AndroidManifest. Default value will be used.
//solution:
//   https://firebase.flutter.dev/docs/messaging/usage/
//3. inisialisasi hanya saat sudah membuka halaman ini saja
//   harus taruh inisialisasi di main

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/fb_message_badge.dart';
import 'package:flutter_application_1/model/pushnotificationdata.dart';
import 'package:overlay_support/overlay_support.dart';

class FBMessageWidget extends StatefulWidget {
  const FBMessageWidget({Key? key}) : super(key: key);

  @override
  State<FBMessageWidget> createState() => _FBMessageWidgetState();
}

class _FBMessageWidgetState extends State<FBMessageWidget> {
  //initialize some values
  late int totalNotificationCounter;
  late FirebaseMessaging messaging;
  //model
  PushNotification? notificationInfo;
  //register notification
  void registerNotification() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted the permission");

      //main message
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data["title"],
          dataBody: message.data['body'],
        );
        setState(() {
          totalNotificationCounter++;
          notificationInfo = notification;
        });

        showSimpleNotification(
          Text(notification.title!),
          leading: NotificationBadgeWidget(
              totalNotification: totalNotificationCounter),
          subtitle: Text(notificationInfo!.body!),
          background: Colors.cyan,
          duration: const Duration(seconds: 2),
        );
      });
    } else {
      print("permission denied by user");
    }
  }

  //check initial message that we receive
  void checkForInitialMessage() async {
    //reinitialize for every firebase function
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data["title"],
          dataBody: message.data['body'],
        );
        setState(() {
          totalNotificationCounter++;
          notificationInfo = notification;
        });
      });
    }
  }

  @override
  void initState() {
    //listen when app is running in background/not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data["title"],
        dataBody: message.data['body'],
      );
      setState(() {
        totalNotificationCounter++;
        notificationInfo = notification;
      });
    });
    //listen when app is in foreground/normal notification
    registerNotification();
    //listen when app is terminated
    checkForInitialMessage();
    totalNotificationCounter = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("Register token")),
              ElevatedButton(
                  onPressed: () {}, child: const Text("Send notification")),
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  "FlutterPushNotification",
                  textAlign: TextAlign.center,
                ),
              ),
              NotificationBadgeWidget(
                  totalNotification: totalNotificationCounter),
              notificationInfo != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "TITLE: ${notificationInfo!.dataTitle ?? notificationInfo!.title}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "BODY: ${notificationInfo!.dataBody ?? notificationInfo!.body}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    )
                  : Container(
                      child: const Text("Waiting for firebase to send the message"),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
