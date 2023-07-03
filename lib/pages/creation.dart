import 'package:fluttacts/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class CreationPage extends StatefulWidget {
  const CreationPage({super.key, this.contactKey});

  final int? contactKey;

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  static final dateFormat = DateFormat("dd/MM/yyyy");
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final Box _contactsBox = Hive.box("contacts");
  DateTime _initialDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final Contact? contact = widget.contactKey != null
      ? Contact.fromMap(_contactsBox.get(widget.contactKey))
      : null;
    if (contact != null) {
      _nameController.text = contact.name;
      _phoneController.text = contact.phone;
      _emailController.text = contact.email;
      if (contact.birthday != null) {
        _birthController.text = contact.birthday!;
        _initialDate = dateFormat.parse(contact.birthday!);
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${contact != null ? "Editar" : "Adicionar"} contato",
            style: appBarTextStyle,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (widget.contactKey != null && contact != null) {
              contact.name = _nameController.text;
              contact.phone = _phoneController.text;
              contact.email = _emailController.text;
              contact.birthday = _birthController.text == "" ? null : _birthController.text;
              _contactsBox.putAt(
                widget.contactKey!,
                contact.toMap(),
              ).then((value) => Navigator.pop(context));
            }
            else {
              _contactsBox.add(
                Contact(
                  name: _nameController.text,
                  phone: _phoneController.text,
                  email: _emailController.text,
                  birthday: _birthController.text == "" ? null : _birthController.text,
                ).toMap(),
              ).then((value) => Navigator.pop(context));
            }
          },
          backgroundColor: iconBackgroundColor,
          tooltip: "Salvar",
          child: const Icon(
            Icons.save,
          ),
        ),
        body: Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                createForm(label: "Nome", controller: _nameController, icon: Icons.person),
                createForm(label: "Número", controller: _phoneController, icon: Icons.phone),
                createForm(label: "Email", controller: _emailController, icon: Icons.email),
                createDateSelection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget createDateSelection() {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Opcional",
            style: TextStyle(
              color: dividerColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: createForm(
                  label: "Data de nascimento",
                  controller: _birthController,
                  icon: Icons.calendar_today,
                  readOnly: true,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: _initialDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      _birthController.text = dateFormat.format(date);
                    }
                  },
                  child: const Text(
                    "Selecionar",
                    style: formValueStyle
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container createForm({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String Function(String?)? validator,
    bool readOnly = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primaryColor,
          ),
          labelText: label,
          hintText: "$label do contato",
          hintStyle: formValueStyle,
          labelStyle: defaultTextStyle,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: dividerColor,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
        style: formValueStyle,
        controller: controller,
        validator: validator,
        readOnly: readOnly,
      ),
    );
  }
}