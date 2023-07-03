import 'dart:math';

import 'package:fluttacts/constants.dart';
import 'package:fluttacts/model/contact.dart';
import 'package:fluttacts/pages/contact_details.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Pesquisar",
            style: appBarTextStyle,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(child: listContacts(query: _searchController.text)),
            ],
          )
        ),
      ),
    );
  }

  Widget listContacts({String? query}) {
    final box = Hive.box("contacts");
    final keys = [];
    final values = [];

    if (query != null) {
      for (int key in box.keys) {
        Map value = box.get(key);
        Contact contact = Contact.fromMap(value);
        if (
          contact.name.toLowerCase().contains(query.toLowerCase()) ||
          contact.email.toLowerCase().contains(query.toLowerCase()) ||
          contact.phone.toLowerCase().contains(query.toLowerCase())
        ) {
          keys.add(key);
          values.add(value);
        }
      }
    } else {
      keys.addAll(box.keys.toList());
      values.addAll(box.values.toList());
    }

    if (values.isEmpty) {
      return const Center(
        child: Text(
          "Nenhum contato encontrado.",
          style: defaultTextStyle,
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: false,
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: false,
          flexibleSpace: SearchBar(
            controller: _searchController,
            hintText: "Pesquise contatos",
            hintStyle: MaterialStateProperty.all(infoStyle),
            textStyle: MaterialStateProperty.all(infoStyle),
            onChanged: (value) {
              setState(() {});
            },
            backgroundColor: MaterialStateProperty.all(darkGray),
            padding: MaterialStateProperty.all(const EdgeInsets.only(left: 14)),
            trailing: _searchController.text.isNotEmpty
                ? [
                    IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          debugPrint("Clear");
                        });
                      },
                      icon: const Icon(
                        Icons.clear,
                        size: 18,
                        color: secondaryColor,
                      ),
                    )
                  ]
                : [],
          ),
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
          childCount: max(0, values.length * 2 - 1),
          (context, index) {
            if (index.isOdd) {
              return const Divider(
                color: dividerColor,
                height: 0,
              );
            }

            Contact contact = Contact.fromMap(values[index ~/ 2]);
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
        },))
      ],
    );
  }
}