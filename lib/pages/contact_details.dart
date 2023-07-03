import 'package:fluttacts/constants.dart';
import 'package:fluttacts/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({super.key, required this.contact});

  final Contact contact;

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Contact contact = widget.contact;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detalhes",
          style: appBarTextStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Open edit page
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Delete contact
            },
          )],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              contact.name,
              style: boldNameStyle,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    contact.phone,
                    style: infoStyle,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: contact.phone)).then((_){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Phone copied to clipboard")));
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    contact.email,
                    style: infoStyle,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: contact.email)).then((_){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email copied to clipboard")));
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              contact.birthday ?? "",
              style: infoStyle,
            ),
          ]
        ),
      )
    );
  }
}