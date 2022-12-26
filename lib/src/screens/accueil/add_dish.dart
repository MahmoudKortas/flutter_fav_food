// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../helpers/db.dart';
import '../../models/dish.dart';
import '../../resize_widget.dart';

class AddDish extends StatefulWidget {
  const AddDish({Key? key}) : super(key: key);
  static const routeName = '/AddDish';
  @override
  State<AddDish> createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  List<Dish>? _dishs;
  File? _image;
  final picker = ImagePicker();
  Dish dish = Dish();
  final descriptionController = TextEditingController();
  final nomController = TextEditingController();
  MyDb mydb = MyDb();
  @override
  void initState() {
    super.initState();
    mydb.open().then((value) {
      log("val::$value");
      // mydb.getDishs();
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add dish'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir nom du plat',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez le nom du plat';
                    }
                    return null;
                  },
                  controller: nomController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir description du plat',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la description du plat';
                    }
                    return null;
                  },
                  controller: descriptionController,
                ),
                TextButton(onPressed: getImage, child: _buildImage()),
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () => addDish(),
                  child: const Text("Ajouter"),
                ),
                /*_document == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/
                _dishs == null
                    ? const Text("aucun plat existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _dishs?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(_dishs![index].name.toString()),
                              subtitle:
                                  Text(_dishs![index].description.toString()),
                              trailing: const Icon(Icons.more_vert),
                              // isThreeLine: true,
                              /* onTap: () => dialog(
                                context,
                                _document![index],
                              ),*/
                            ),
                          );
                        },
                      )
                /*Card(
                  child: ListTile(
                      /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                      title: const Text('SampleItem'),
                      subtitle: const Text(
                          'A sufficiently long subtitle warrants three lines.'),
                      trailing: const Icon(Icons.more_vert),
                      isThreeLine: true,
                      onTap: () => dialog(context)),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
                  ),
                ),
             */
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* Future<String?> dialog(BuildContext context, Document document) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer document'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                  "http://10.0.2.2:8080/api/document/image/${document.idDoc}"),

              // Image.asset("assets/images/logo-epi.png"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Annuler'),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Modifer'),
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(document.idDoc.toString());
              var _documentt;
              _documentt = await ApiService()
                  .deleteDocument(id: document.idDoc.toString());
              log("_documentt::$_documentt");
              // getData();
              Navigator.pop(context, 'Supprimer');
            },
            child: const Text('Supprimer'),
          ),
          /*TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),*/
        ],
      ),
    );
  }
*/
  void getData() async {
    _dishs = await mydb.getDishs();
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  addDish() async {
    dish.description = descriptionController.text;
    dish.name = nomController.text;
    mydb.db.rawInsert(
        "INSERT INTO food (name, description, img_path) VALUES (?, ?, ?);",
        [dish.name, dish.description, _image?.path]).then(
      (value) {
        if (value != 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("New dish Added"),
            ),
          );
          /* Navigator.pushNamed(
                                    context,
                                    Authentification.routeName,
                                  );*/
        }
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      );
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        log('No image selected.');
      }
    });
  }

  Widget _buildImage() {
    if (_image == null) {
      return const Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Text(_image!.path);
    }
  }
}
