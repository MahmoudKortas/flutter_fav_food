// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_fav_food/src/models/user.dart';
import 'package:flutter_fav_food/src/screens/accueil/list_dish_user.dart';
import '../../resize_widget.dart';
import '../../size_config.dart';
import 'add_dish.dart';
import 'list_dish_admin.dart';

/// Displays detailed information about a SampleItem.
class HomeScreen extends StatefulWidget {
  User user;
  HomeScreen({Key? key, required this.user}) : super(key: key);

  static const routeName = '/HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("HomeScreen User::${widget.user}");
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("home screen"),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      log("list");
                      widget.user.permission!.contains("Admin")
                          ? Navigator.restorablePushNamed(
                              context,
                              ListDishAdmin.routeName,
                            )
                          : Navigator.restorablePushNamed(
                              context,
                              ListDishUser.routeName,
                            );
                    },
                    child: const Text('list'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.user.permission!.contains("Admin")
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            log("add");
                            Navigator.restorablePushNamed(
                              context,
                              AddDish.routeName,
                            );
                          },
                          child: const Text('add'),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            log("fav");
                            Navigator.restorablePushNamed(
                              context,
                              ListDishAdmin.routeName,
                            );
                          },
                          child: const Text('fav'),
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
