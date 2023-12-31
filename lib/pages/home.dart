import 'package:fluttacts/model/contact.dart';
import 'package:fluttacts/pages/contact_details.dart';
import 'package:fluttacts/pages/creation.dart';
import 'package:fluttacts/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fluttact",
          style: appBarTextStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreationPage(),
                ),
              ).then((value) => setState(() {}));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              ).then((value) => setState(() {}));
            },
          )
        ],
      ),
      body: listContacts()
    );
  }

  Widget listContacts() {
    final box = Hive.box("contacts");
    final keys = box.keys.toList();
    final values = box.values.toList();

    if (values.isEmpty) {
      return const Center(
        child: Text(
          'No contacts found',
          style: defaultTextStyle,
        ),
      );
    }

    return ListView.separated(
      itemCount: values.length,
      itemBuilder: (context, index) {
        Contact contact = Contact.fromMap(values[index]);
        return ListTile(
          leading: Container(
            decoration: const BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            width: 36,
            height: 36,
            child: const Icon(Icons.person)
          ),
          title: Text(
            contact.name,
            style: nameStyle,
          ),
          subtitle: Text(
            contact.phone,
            style: subtitleStyle,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactDetailsPage(contactKey: keys[index]),
              ),
            ).then((value) => setState(() {}));
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: dividerColor,
          height: 0,
        );
      },
    );
  }
}
