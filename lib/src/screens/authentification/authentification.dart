// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import '../../color_hex.dart'; 
import '../../helpers/db.dart';
import '../../models/user.dart';
import '../../resize_widget.dart';
import '../../size_config.dart'; 
import '../accueil/home_screen.dart'; 
import 'inscription.dart';

/// Displays detailed information about a SampleItem.
class Authentification extends StatefulWidget {
  const Authentification({Key? key}) : super(key: key);

  static const routeName = '/Authentification';
  @override
  State<Authentification> createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final motDePasseController = TextEditingController();
  var _enseignant;
  var _etudiant;
  var _responsable;
  MyDb mydb = MyDb();
  @override
  void initState() {
    super.initState();
    // mydb.deleteDatabase("/data/user/0/com.testapp.flutter.testapp/databases/food.db");
    mydb.open().then((value) => mydb.getUsers());

    // getData();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    loginController.dispose();
    motDePasseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("S'authentifier"),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo-epi.png",
                  scale: 3,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Saisir votre login',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'entrez votre login';
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
                            return 'entrez votre mot de passe';
                          }
                          return null;
                        },
                        controller: motDePasseController,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            /*if (_formKey.currentState!.validate()) {
                          // Process data.
                        }*/
                            var user = await mydb.db.query('users',
                                where: 'login = ? and password=?',
                                whereArgs: [
                                  loginController.text,
                                  motDePasseController.text
                                ]);
                            User u = User.fromJson(user.first);
                            //getting student data with roll no.
                            log("user::$u");
                            log("signin ${loginController.text} ${motDePasseController.text}");
                            /*verificationInscription(
                                login: loginController.text,
                                motDepasse: motDePasseController.text);*/
                            Navigator.pushNamed(
                                context, HomeScreen.routeName,
                                arguments: HomeScreen(user: u));
                          },
                          child: const Text('Connexion'),
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "Inscription",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                            color: HexColor("c9242e"),
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          Navigator.restorablePushNamed(
                            context,
                            Inscription.routeName,
                          );
                        },
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
 

 
}
