// ignore_for_file: unnecessary_this

// import 'package:delivery_food/src/ui/global_widgets/svg_from_asset.dart';
// import 'package:delivery_food/src/utils/app/app_utils.dart';
import 'package:delivery_food/src/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleButton extends StatelessWidget {
  //variables que pasaremos por parametro pa que se ponga :D
  final VoidCallback? onPressed;
  final String iconPath;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  // constructor
  CircleButton({
    Key? key,
    required this.onPressed,
    required this.iconPath,
    this.size = 40.0,
    this.backgroundColor = primarycolor,
    this.iconColor = Colors.white,
  })  : assert(size > 0), //tambien se puede usar assert para validar propiedades de nuestro widget
        // assert(iconPath != null), no puede ser nulo
        assert(iconPath.contains(".svg")), //que contenga .svg :D
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: this.onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        width: this.size,
        height: this.size,
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: this.backgroundColor,
          shape: BoxShape.circle,
        ),
        // pusimos un condicional por el renderizado web pk antes svgpicture no esta compatible con la web pero ya lo es
        // child:AppUtils.isHtml ? Image.network(this.iconPath, color: this.iconColor) : SvgPicture.asset( forma 1
        // child: SvgFromAsset(path: this.iconPath, color: this.iconColor), con widget nuestro
        child: SvgPicture.asset(
          this.iconPath,
          color: this.iconColor,
        ),
      ),
    );
  }
}
