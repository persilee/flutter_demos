import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationPage extends StatefulWidget {
  final RemoteMessage? message;

  const PushNotificationPage({Key? key, this.message}) : super(key: key);

  @override
  State<PushNotificationPage> createState() => _PushNotificationPageState();
}

class _PushNotificationPageState extends State<PushNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Messaging'),
      ),
      body: Center(
        child: Text(widget.message?.notification?.title ?? ''),
      ),
    );
  }
}
