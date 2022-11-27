// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_fav_food/src/screens/authentification/authentification.dart'; 
import '../../resize_widget.dart';
import '../../size_config.dart'; 
import 'inscription.dart';

/// Displays detailed information about a SampleItem.
class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  static const routeName = '/FirstScreen';
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
        title: const Text("Fav food app"),
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
                      log("SignIn");
                      Navigator.restorablePushNamed(
                        context,
                        Authentification.routeName,
                      );
                    },
                    child: const Text('SignIn'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      log("signUp");

                      Navigator.restorablePushNamed(
                        context,
                        Inscription.routeName,
                      );
                    },
                    child: const Text('signUp'),
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
