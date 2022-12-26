// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
import '../../helpers/db.dart';
import '../../models/dish.dart'; 
import '../../resize_widget.dart';

class ListFav extends StatefulWidget {
  const ListFav({Key? key}) : super(key: key);
  static const routeName = '/ListFav';
  @override
  State<ListFav> createState() => _ListFavState();
}

class _ListFavState extends State<ListFav> {
  List<Dish>? _dishs; 
  File? _image;
  MyDb mydb = MyDb();
  @override
  void initState() {
    super.initState();
    mydb.open().then((value) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List dish'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                _dishs != null
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _dishs?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: Image.file(
                                File(_dishs![index].img_path ?? ""),
                              ),
                              title: Text(
                                _dishs![index].name.toString(),
                              ),
                              subtitle: Text(
                                _dishs![index].description.toString(),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => dialog(
                                      context,
                                      _dishs![index],
                                    ),
                                    icon: const Icon(
                                      Icons.favorite,
                                      // color: Colors.yellow,
                                    ),
                                  ),
                                 ],
                              ),
                              onTap: () => dialog(
                                context,
                                _dishs![index],
                              ),
                            ),
                          );
                        },
                      )
                    : const Text("aucun plat existe")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context, Dish dish) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer document'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              
              const SizedBox(
                height: 10,
              ),
             
              Image.file(
                File(_image?.path ?? dish.img_path ?? ""),
              ),
             
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Annuler'),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              log(dish.id.toString());
              mydb.db.rawUpdate(
                  'UPDATE food set name=? ,description=? ,img_path=? WHERE id = ?',
                  [
                    dish.name,
                    dish.description,
                    _image?.path ?? dish.img_path,
                    dish.id
                  ]).then(
                (value) {
                  log("edit dish::$value");
                  Navigator.pop(context, 'modifier');
                },
              );
            },
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(dish.id.toString());
              mydb.db
                  .rawDelete('DELETE FROM food WHERE id = ?', [dish.id]).then(
                (value) {
                  log("delet dish::$value");
                  Navigator.pop(context, 'Supprimer');
                },
              );
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  void getData() async {
    _dishs = await mydb.getFav();
    log("dishs::$_dishs");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
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
