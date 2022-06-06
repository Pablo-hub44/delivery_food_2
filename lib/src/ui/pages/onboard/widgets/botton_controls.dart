// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/pages/onboard/onboard_controller.dart';
import 'package:delivery_food/src/utils/colors.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class OnboardControles extends StatelessWidget {
  const OnboardControles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _Dots(),
          Consumer<OnboardController>(
            builder: (_, controller, __) {
              final double page = controller.currentPage;
              bool isEnd = page % 1 == 0 && page == 2.0; //osease q si esta en la pag final
              return CupertinoButton(
                child: Text(
                  isEnd ? "Comenzar" : "Siguiente",
                  style: FontStyles.titulo.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  print("tapeado");
                  _onNext(context, controller);
                },
                color: primarycolor,
                borderRadius: BorderRadius.circular(30.0),
              );
            },
          ),
        ],
      ),
    );
  }

  //metodo, pa las paginas el onboard
  void _onNext(BuildContext context, OnboardController controller) {
    // si esta en la pos 2 lo lleve a welcome
    if (controller.currentPage == 2) {
      Navigator.pushReplacementNamed(context, Routes.Welcome);
    } else {
      //para que al presionar se valla a las sig paginas | controller asignado de PageController
      // nenxtpage es un metodo propio de flutter para q valla a la sig pag
      controller.pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }
}

class _Dots extends StatelessWidget {
  const _Dots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final controllerr = Provider.of<OnboardController>(context); //op1.
    final controllerr = context.watch<OnboardController>(); //op2

    return DotsIndicator(
      //widget cool externo para el dots
      dotsCount: controllerr.items.length,
      position: controllerr.currentPage,
      decorator: DotsDecorator(
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        color: Colors.grey.withOpacity(0.4),
        activeColor: primarycolor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );

    // return Container( old echo por nosotros :D
    //   child: Row(
    //     children: List.generate(
    //       controllerr.items.length,
    //       (index) => Container(
    //         margin: EdgeInsets.only(right: 5),
    //         width: 15,
    //         height: 15.0,
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           border: Border.all(width: 3, color: controllerr.currentPage == index ? primarycolor : Colors.white),
    //           color: Colors.grey.withOpacity(0.3),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
