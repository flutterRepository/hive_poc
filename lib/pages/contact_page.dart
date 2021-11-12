import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_poc/models/contact.dart';
import 'package:hive_poc/pages/new_contact_form.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 10,
        ),
        child: Column(
          children: [
            Expanded(
              child: _buildListView(),
            ),
            const NewContactForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    // return ValueListenableBuilder(
    //   valueListenable: Hive.box("contacts").listenable(),
    //   child: Container(),
    //   builder: (context, contactsBox) {},
    // );
    return WatchBoxBuilder(
      box: Hive.box("contacts"),
      builder: (context, contactsBox) {
        return ListView.builder(
          itemCount: contactsBox.length,
          itemBuilder: (context, index) {
            final contact = contactsBox.getAt(index) as Contact;
            return ListTile(
              title: Text(
                contact.name,
              ),
              subtitle: Text(contact.age.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      contactsBox.putAt(
                        index,
                        Contact(name: "${contact.name}*", age: contact.age + 1),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                  IconButton(
                    onPressed: () {
                      contactsBox.deleteAt(index);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
