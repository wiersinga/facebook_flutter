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
  String gender = "";

  bool isManChecked = false;
  bool isFemaleChecked = false;

  double _currentSliderValue = 0;

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

  void _handleManCheckBoxChange(bool? value){
    setState(() {
      isManChecked = value!;
      if (isManChecked) {
        isFemaleChecked = false;
        gender = "man";
      }
    });
  }

  void _handleFemaleCheckBoxChange(bool? value){
    setState(() {
      isFemaleChecked= value!;
      if (isFemaleChecked){
        isManChecked = false;
        gender = "female";
      }
    });
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
              Container(
                color: Colors.greenAccent,
                height: 600,
                width: double.infinity,// Set the background color here
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage("https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600"),
                    ),
                    Text('My name is :' + ' ' + firstNameTextEditingController.text+ '  ' +lastNameTextEditingController.text, style: TextStyle(fontSize: 22)),
                    Text( 'My age is : ' +age, style: TextStyle(fontSize: 22)),
                    Text('I `am a :' + gender, style: TextStyle(fontSize: 22)),
                    Text('I`m measuring: ' +
                        _currentSliderValue.toString(),
                    style: TextStyle(fontSize: 22)
                    ),
                    Row(
                      children: [
                        const Text('My favorite books :'),
                        Expanded(
                            child: SizedBox(
                              height: 150,
                              child: buildBody(),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First name',
                ),
                controller: firstNameTextEditingController,
                onChanged: ((value)=> setState(() {})),
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last name',
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
              /*Row(
                children: [
                  const Text('My favorite books :'),
                  Expanded(
                      child: SizedBox(
                    height: 150,
                    child: buildBody(),
                  ))
                ],
              ),*/
              Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 50
                      ),
                      const Text(
                        'Female',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Checkbox(
                          value: isFemaleChecked,
                          onChanged: _handleFemaleCheckBoxChange
                          ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                          width: 50
                      ),
                      const Text(
                        'Man',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Checkbox(
                          value: isManChecked,
                          onChanged: _handleManCheckBoxChange
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("I measure ..."),
                      Slider(
                      value: _currentSliderValue,
                      max: 200,
                      divisions: 200,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value!;
                        });
                      }
                      ),
                    ],
                  )

                ],
              ),
              ],
          ),
        ],
      )
    );
  }

}