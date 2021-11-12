import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_poc/models/contact.dart';

class NewContactForm extends StatefulWidget {
  const NewContactForm({Key? key}) : super(key: key);

  @override
  State<NewContactForm> createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _age;

  void addContact(Contact contact) {
    log("Name : ${contact.name}, Âge : ${contact.age}");
    final contactsBox = Hive.box("contacts");
    contactsBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Name"),
                  onSaved: (value) => _name = value!,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Âge"),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _age = value!,
                ),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              _formKey.currentState!.save();
              final newContact = Contact(name: _name, age: int.parse(_age));
              addContact(newContact);
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
            ),
            child: const Text(
              "Ajouter un nouveau contact",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
