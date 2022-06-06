import 'package:delivery_food/src/data/modelos/onboard_item.dart';
import 'package:delivery_food/src/ui/pages/onboard/onboard_controller.dart';
import 'package:delivery_food/src/utils/app/app_utils.dart';
// import 'package:delivery_food/src/utils/app/check_web_render.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// parte de la vista del onboard
class OnboardSlider extends StatelessWidget {
  const OnboardSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnboardController>(context, listen: false);
    // expanded pa q ocupe todo el espacio, o no tener error de overflow
    return Expanded(
      child: PageView(
        // PageView como una vista de paginas, va a tomar el tamaño de nuestra lista de items
        controller: controller.pageController, //el controller de la page
        children: List.generate(controller.items.length, (index) {
          final OnboardItem item = controller.items[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Expanded(
                  // child: SvgPicture.asset(item.image), antes
                  // si se ejecuta en web entonces imagen.network sino SvgPicture
                  child: AppUtils.isHtml ? Image.network(item.image) : SvgPicture.asset(item.image),
                ),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: FontStyles.titulo, //mi fuente
                  //TextStyle(fontWeight: FontWeight.bold, fontSize: 20), antes
                ),
                const SizedBox(height: 20),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: FontStyles.normal,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
