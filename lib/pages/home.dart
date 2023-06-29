import 'package:flutter/material.dart';

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
          'Fluttact',
          style: appBarTextStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Open add contact page
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Open search page
            },
          )
        ],
      ),
      body: listContacts(),
    );
  }

  Widget listContacts() {
    List contacts = [
      'Contact 1 a',
      'Contact 2 b',
      'Contact 3 c',
      'Contact 4 d',
      'Contact 5 e',
      'Contact 6 f',
      'Contact 7 g',
      'Contact 8 h',
      'Contact 9 i',
      'Contact 10 j',
    ];

    List numbers = [
      '123456789',
      '223456789',
      '323456789',
      '423456789',
      '523456789',
      '623456789',
      '723456789',
      '823456789',
      '923456789',
      '023456789',
    ];

    if (contacts.isEmpty) {
      return const Center(
        child: Text(
          'No contacts found',
          style: defaultTextStyle,
        ),
      );
    }

    return ListView.separated(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
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
            contacts[index],
            style: nameStyle,
          ),
          subtitle: Text(
            numbers[index],
            style: phoneStyle,
          ),
          onTap: () {
            // Open contact details
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
