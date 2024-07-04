import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget{
  /*const ProfilePage({super.key});*//**/
  @override
  ProfilePageState createState()=> ProfilePageState();

}

class ProfilePageState extends State<ProfilePage> {
  List<String> ages = <String>['18','19','20','21','22','23','24','25','26','27','28'];

  String age = "";

  late TextEditingController firstNameTextEditingController;
  late TextEditingController lastNameTextEditingController;

  @override
  void initState() {
    super.initState();
    firstNameTextEditingController = TextEditingController();
    lastNameTextEditingController = TextEditingController();

  }

  @override
  void dispose(){
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile page"),
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage("https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600"),
              ),
              Text(firstNameTextEditingController.text),
              Text(lastNameTextEditingController.text),
              Text(age),
            ],
          ),
          Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Prénom',
                ),
                controller: firstNameTextEditingController,
                onChanged: ((value)=> setState(() {})),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom',
                ),
                controller: lastNameTextEditingController,
                onChanged: ((value)=> setState(() {})),
              ),
              DropdownButton<String>(
                  value: ages.first,
                  items: ages.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
              }).toList(),
                  onChanged: ((value)=> setState(() {
                    age = value!;
                  })
              ),
              ),
              ],
          ),
        ],
      )
    );
  }

}