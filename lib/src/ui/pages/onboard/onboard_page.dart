// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

// import 'package:delivery_food/src/ui/global_controllers/notification_controller.dart';
import 'package:delivery_food/src/ui/pages/onboard/onboard_controller.dart';
import 'package:delivery_food/src/ui/pages/onboard/widgets/botton_controls.dart';
import 'package:delivery_food/src/ui/pages/onboard/widgets/slider.dart';
// import 'package:delivery_food/src/utils/colors.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // traemos nuestro notification controller
    // context.read<NotificationsController>();

    return ChangeNotifierProvider<OnboardController>(
      // el contexto es para saber donde esta nuestro widget en el arbol de widgets, generalmente busca al contexto padre , o de este contest para los windget hijo que lo necesiten
      // antes (_)
      create: (context) {
        final controller = OnboardController();
        //con esto hara que nuestra pagina renderize sin problema, que tome su tiempo, y no es nulo
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          controller.afterFirstlayout();
        });
        return controller;
      },
      builder: (context, __) => Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              children: const [
                OnboardSlider(),
                SizedBox(height: 50.0),
                OnboardControles(),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
