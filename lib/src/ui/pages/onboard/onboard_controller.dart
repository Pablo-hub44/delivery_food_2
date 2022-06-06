import 'package:delivery_food/src/data/modelos/onboard_item.dart';
import 'package:flutter/material.dart';

class OnboardController extends ChangeNotifier {
  final List<OnboardItem> items = [
    OnboardItem(
      image: "assets/pages/onboard/img1.svg",
      title: "Trabajo colaborativo",
      description: "Ullamcorper bibendum penatibus nunc proin dui aliquam quis, egestas purus ridiculus sociis integer quam",
    ),
    OnboardItem(
      image: "assets/pages/onboard/img2.svg",
      title: "Interfaz moderna",
      description: " bibendum penatibus nunc proin dui aliquam quis, egestas purus ridiculus sociis integer quam",
    ),
    OnboardItem(
      image: "assets/pages/onboard/img3.svg",
      title: "Administra mejor tu tiempo",
      description: "Ullamcorper bibendum nunc proin dui aliquam quis, egestas purus ridiculus sociis integer quam",
    )
  ];

  final PageController pageController = PageController();
  double _currentPage = 0; //pagina actual
  //como era un valor privado, con get lo podemos usar
  double get currentPage => _currentPage;

  //solo se ejecuta una ves el principio, es como el initState de stful
  void afterFirstlayout() {
    pageController.addListener(() {
      final double page = pageController.page!; //! no es nulo pk ya asignamos el tamaño en slider pageview
      _currentPage = page; //la page de pageController le a ponemos a currentPage
      notifyListeners();

      //para que tome solo las paginas y no los scrolls demas|| ya no pk ocupamos dots_indicator
      // if (page % 1 == 0 && _currentPage != page) {
      //   _currentPage = page.toInt();
      //   notifyListeners();
      //   print("current page ${pageController.page}");
      // }
    });
  }

  //para que deje de ocupar recursos | aunque no sean muchos recursos, deje de escuchar cambios
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
