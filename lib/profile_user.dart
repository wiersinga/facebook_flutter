import 'dart:ui';
import 'package:facebook_flutter/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget{

  @override
  ProfilePageState createState()=> ProfilePageState();

}


class ProfilePageState extends State<ProfilePage> {
  List<String> ages = <String>['18','19','20','21','22','23','24','25','26','27','28'];
  BookList bookList = BookList(docs: []);
  bool isLoading = true;
  String errorMessage = '';

  String age = "";

  late TextEditingController firstNameTextEditingController;
  late TextEditingController lastNameTextEditingController;

  @override
  void initState() {
    super.initState();
    firstNameTextEditingController = TextEditingController();
    lastNameTextEditingController = TextEditingController();
    fetchData();
  }

  @override
  void dispose(){
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    super.dispose();
  }

  Future<BookList> fetchDataResponse() async {
    final response = await http.get(Uri.parse('https://the-one-api.dev/v2/book'));

    await Future.delayed(Duration(seconds: 2));

    if (response.statusCode == 200) {
      /*Map<String, dynamic> jsonResponse = json.decode(response.body);*/
      return BookList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<void> fetchData() async {
    try {
      var books = await fetchDataResponse();
      setState(() {
        bookList = books;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  Widget buildBody(){
    if (isLoading){
      return Container(
        child: CircularProgressIndicator(),
      );
    }
    if (errorMessage.isNotEmpty){
      return Container(
        child: Text('Error: $errorMessage'),
      );
    }
    if (bookList.docs!.isEmpty){
      return Container(
        child: Text('No items founs'),
      );
    }
    return ListView.builder(
      itemCount: bookList.docs!.length,
      itemBuilder: (context, index){
        return ListTile(
          leading: Icon(Icons.label),
          title: Text(bookList.docs![index].name ?? ''),
        );
      },
    );
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
              Container(
                height: 300,
                child: buildBody(),
              ),
              ],
          ),
        ],
      )
    );
  }

}