// ignore_for_file: unnecessary_this

// import 'package:delivery_food/src/utils/colors.dart';
import 'package:delivery_food/src/utils/colors.dart';
import 'package:flutter/material.dart';

//tipo boxdecotarion
class HomeTabBarIndicator extends Decoration {
  //variables que pasaremos por parametro
  final Color color;
  final double size;

  const HomeTabBarIndicator({
    this.color = primarycolor,
    required this.size,
  });
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(this.color, this.size);
  }
}

class _CustomPainter extends BoxPainter {
  final Color color;
  final double size;

  _CustomPainter(this.color, this.size);
  @override
  void paint(
    Canvas canvas,
    Offset offset, //pasa la posicion del widget
    ImageConfiguration configuration,
  ) {
    final Paint paint = Paint(); //instancia de paint
    paint.color = this.color;
    final width = configuration.size!.width; //con esto ya tenemos el ancho de mi tab
    final height = configuration.size!.height; //con esto ya tenemos la altura de mi tab
    final Offset posicion = Offset(offset.dx + width / 2, offset.dy + height - 4); //y asi hacemos q se ponga en medio
    canvas.drawCircle(posicion, this.size / 2, paint); //canvas es el lienzo y  el paint es el pincel
  }
}
