import 'package:delivery_food/src/utils/app/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// para saber si se esta renderizando en web, para usar image.network o svgPicture, aunque svgpicture ya es compatible con web
class SvgFromAsset extends StatelessWidget {
  final String path;
  final Color? color;
  final double? width;
  final double? height;

  // constructor
  const SvgFromAsset({Key? key, required this.path, this.color, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppUtils.isHtml
        ? Image.network(
            path,
            color: color,
            width: width,
            height: height,
          )
        : SvgPicture.asset(
            path,
            color: color,
            width: width,
            height: height,
          );
  }
}
