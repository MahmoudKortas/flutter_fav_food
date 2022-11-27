import 'package:flutter/widgets.dart'; 
import 'responsive_utils.dart';
import 'size_config.dart';

Widget resiseWidget({BuildContext? context, Widget? child}) {
  return SizedBox(
      width: getResponsiveDouble(
          context: context,
          extraSmall: SizeConfig.safeBlockHorizontal! * 90,
          small: SizeConfig.safeBlockHorizontal! * 80,
          medium: SizeConfig.safeBlockHorizontal! * 70,
          large: SizeConfig.safeBlockHorizontal! * 60,
          extraLarge: SizeConfig.safeBlockHorizontal! * 50),
      child: child);
}
