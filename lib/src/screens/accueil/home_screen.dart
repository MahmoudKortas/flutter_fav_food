// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_fav_food/src/screens/authentification/authentification.dart'; 
import '../../resize_widget.dart';
import '../../size_config.dart';
import 'add_dish.dart';
import 'list_dish.dart';  

/// Displays detailed information about a SampleItem.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                      Navigator.restorablePushNamed(
                        context,
                        ListDish.routeName,
                      );
                    },
                    child: const Text('list'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      log("fav");

                      Navigator.restorablePushNamed(
                        context,
                        ListDish.routeName,
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
