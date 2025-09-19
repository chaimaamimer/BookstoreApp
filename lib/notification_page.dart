import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: const Text("Notification",style:TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //icon
          Image.asset('assets/icons/Frame (6).png'),
          Text('There is no notification',style:TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}