import 'dart:ui';

import 'package:facebook_flutter/profile_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Facebook',
        debugShowCheckedModeBanner: false,
        home: ProfilePage(),

    );
  }
}
   /*   Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
          elevation: 2,
          shadowColor: Colors.blueAccent,
        ),
        body: Column(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdZG6SCpYUZvdJgto4OPoq0p-_Icme3wnKJg&usqp=CAU'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            CircleAvatar(
              radius: 80,
              backgroundImage: const NetworkImage("https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600"),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text(
                'Olfa Wiersinga',
                    textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
                Text(
                  'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}*/
