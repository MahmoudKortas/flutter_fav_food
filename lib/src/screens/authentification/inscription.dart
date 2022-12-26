import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_fav_food/src/screens/authentification/authentification.dart';
import '../../helpers/db.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);
  static const routeName = '/inscription';
  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _items = ['Admin', 'User'];

  String? permissionValue;

  final loginController = TextEditingController();
  final motDePasseController = TextEditingController();
  final domaineController = TextEditingController();
  MyDb mydb = MyDb();
  @override
  void initState() {
    super.initState();
    mydb.open().then((value) => mydb.getUsers());
    // getData();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    loginController.dispose();
    motDePasseController.dispose();
    domaineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S'inscrire"),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.login),
                          hintText: 'Saisir votre login',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre login';
                          }
                          return null;
                        },
                        controller: loginController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Saisir votre mot de passe',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre mot de passe';
                          }
                          return null;
                        },
                        controller: motDePasseController,
                      ),
                      DropdownButton<String>(
                        hint: const Text("Permission"),
                        value: permissionValue,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => permissionValue = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            log("${loginController.text} ${motDePasseController.text} $permissionValue  ");
                            mydb.db.rawInsert(
                                "INSERT INTO users (login, password, permission) VALUES (?, ?, ?);",
                                [
                                  loginController.text,
                                  motDePasseController.text,
                                  permissionValue
                                ]).then(
                              (value) {
                                if (value != 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("New user Added"),
                                    ),
                                  );
                                  Navigator.pushNamed(
                                    context,
                                    Authentification.routeName,
                                  );
                                }
                              },
                            );
                          },
                          child: const Text("S'inscrire"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      ); // DropdownMenuItem
}
