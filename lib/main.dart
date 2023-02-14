import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import "./person.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                "Test form",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          body: Homepage(),
        ),
      ),
    );
  }
}

class Homepage extends StatelessWidget {
  final Uri url = Uri.parse(
      "https://flutter-try-61f91-default-rtdb.europe-west1.firebasedatabase.app/person.json");
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final ageController = TextEditingController();
  List<Person> person = [];

  void submitData() {
    final enteredName = nameController.text;
    final enteredSurname = surnameController.text;
    final enteredAge = int.parse(ageController.text);

    if (enteredName.isEmpty || enteredSurname.isEmpty || enteredAge < 0) {
      return;
    }

    final newPerson = Person(enteredName, enteredSurname, enteredAge);
    person.add(newPerson);
    http.post(
      url,
      body: json.encode(
        {
          "name": newPerson.name,
          "surname": newPerson.surname,
          "age": newPerson.age,
        },
      ),
    );
    nameController.clear();
    surnameController.clear();
    ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Enter your personal details below",
              style: TextStyle(color: Colors.black, fontSize: 23),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Name",
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextField(
            controller: surnameController,
            decoration: const InputDecoration(
              labelText: "Surname",
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextField(
            controller: ageController,
            decoration: const InputDecoration(
              labelText: "Age",
            ),
          ),
          TextButton(
            onPressed: submitData,
            child: const Text("SEND"),
          )
        ],
      ),
    );
  }
}
