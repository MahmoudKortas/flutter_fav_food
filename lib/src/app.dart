import 'package:flutter/material.dart';
import 'package:flutter_fav_food/src/screens/accueil/list_dish_user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'custom_theme.dart';
import 'screens/accueil/add_dish.dart';
import 'screens/accueil/home_screen.dart';
import 'screens/accueil/list_dish_admin.dart';
import 'screens/authentification/first_screen.dart';
import 'screens/authentification/authentification.dart';
import 'screens/authentification/inscription.dart'; 
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          /*theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,*/
          darkTheme: lightTheme, //darkTheme,
          theme: lightTheme,
          themeMode: ThemeMode.system,
          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case FirstScreen.routeName:
                    return const FirstScreen();
                  case Authentification.routeName:
                    return const Authentification();
                  case Inscription.routeName:
                    return const Inscription();
                  case HomeScreen.routeName:
                    final args = routeSettings.arguments as HomeScreen;
                    return HomeScreen(user: args.user);
                  case AddDish.routeName:
                    return const AddDish();
                  case ListDishAdmin.routeName:
                    return const ListDishAdmin();
                  case ListDishUser.routeName:
                    return const ListDishUser(); 
                  default:
                    return const FirstScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}
