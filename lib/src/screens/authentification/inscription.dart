import 'dart:developer';

import 'package:flutter/material.dart';
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
 
  String? domaineValue; 
  
  final loginController = TextEditingController();
  final motDePasseController = TextEditingController();

  final domaineController = TextEditingController();  

  @override
  void initState() {
    super.initState();
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
                        value: domaineValue,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => domaineValue = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            log("${loginController.text} ${motDePasseController.text} $domaineValue  ");
                            /*addEnseignant(
                                    nom: nomController.text,
                                    prenom: prenomController.text,
                                    telephone: telephoneController.text,
                                    adresse: adresseController.text,
                                    login: loginController.text,
                                    motDePasse: motDePasseController.text,
                                    domaine: domaineValue)
                           
                                     addStudent(
                                        nom: nomController.text,
                                        prenom: prenomController.text,
                                        telephone: telephoneController.text,
                                        adresse: adresseController.text,
                                        login: loginController.text,
                                        motDePasse: motDePasseController.text,
                                        diplome: diplomeValue,
                                        departement: departementValue,
                                        niveau: niveauValue,
                                        specialite: specialiteValue)*/
                    
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            /*if (_formKey.currentState!.validate()) {
                          // Process data.
                        }*/
                            /*Navigator.restorablePushNamed(
                                context, Authentification.routeName);*/

                            //
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

  /*void getData() async {
    _pfe = await ApiService().getPFE();
    _document = await ApiService().getDocument();
    _soutenance = await ApiService().getSoutenance();
    log("_soutenance::$_soutenance");
    log("pfe::$_pfe");
    log("_document::$_document");
  }
  /*void getData() async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    _etudiant = await ApiService().getEtudiants();
    _enseignant = await ApiService().getEnseignant();
    log("_etudiant::$_etudiant");
    log("_enseignant::$_enseignant");
  }*/

  void addStudent({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? login = "",
    String? motDePasse = "",
    String? diplome = "",
    String? departement = "",
    String? niveau = "",
    String? specialite = "",
  }) async {
    log("addStudent");
    await ApiService().addEtudiants(
        nom: nom,
        prenom: prenom,
        telephone: telephone,
        adresse: adresse,
        login: login,
        motDePasse: motDePasse,
        diplome: diplome,
        departement: departement,
        niveau: niveau,
        specialite: specialite);
  }

  void addEnseignant({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? login = "",
    String? motDePasse = "",
    String? domaine = "",
  }) async {
    log("addEnseignant");
    var e = await ApiService().addEnseignant(
        nom: nom,
        prenom: prenom,
        telephone: telephone,
        adresse: adresse,
        login: login,
        motDePasse: motDePasse,
        domaine: domaine);
    e!.isNotEmpty
        ? log("addEnseignantENotEmpty::$e")
        : log("addEnseignantEempty::$e");
  }

  void radiochange(Description? value) {
    setState(() {
      _description = value!;
    });
    /*if (kDebugMode) {
      print("_description::$_description");
      print("value::$value");
    }*/
  }*/

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      ); // DropdownMenuItem
}
