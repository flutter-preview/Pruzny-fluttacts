import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class CreationPage extends StatefulWidget {
  const CreationPage({super.key});

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  static final dateFormat = DateFormat('dd/MM/yyyy');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adicionar contato',
          style: appBarTextStyle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add contact
        },
        backgroundColor: iconBackgroundColor,
        tooltip: "Salvar",
        child: const Icon(
          Icons.save,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(16.0),
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
                      initialDate: DateTime.now(),
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
    bool readOnly = true,
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