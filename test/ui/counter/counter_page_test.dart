// ignore_for_file: avoid_print, unused_local_variable

import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'counter_page.dart';

void main() {
  testWidgets('el CounterPage', (WidgetTester testerr) async {
    await testerr.pumpWidget(MaterialApp(
      home: const CounterPage(), // para q funciones tiene q estar dentro de un materialApp
      theme: ThemeData(
        textTheme: FontStyles.textTheme,
      ),
    )); //con pumpwidget traemos CounterPage a aca
    expect(find.text("0"), findsOneWidget); //buscara el widget q tengo un texto 0 en cunterPage
    final button = find.byType(TextButton); //otra forma de buscar por el tipo q tiene el texto addd
    final buttonn = find.byKey(const Key('add')); //otra forma de buscar por la key q tiene el boton | la key debe ser unica

    await testerr.tap(find.text("Addd"));
    // - la diferencia entre pump y pumpAndsettle, pump solo renderiza al sig frame pocos frames, mientras q pumpsettle renderiza varios frames
    await testerr.pump();
    expect(find.text("1"), findsOneWidget); //al hacer tap y actualizar el frame con pump. el sig seria 1

    await testerr.tap(find.text("Addd")); //2 find.text busca en un widget padre que sea un boton q tenga un texto addd
    await testerr.tap(buttonn); //3
    await testerr.tap(find.text("Addd")); //4
    // final result = await testerr.pumpAndSettle(); //pratiamente lo mismo
    // print(result);
    await testerr.pump();
    expect(find.text("4"), findsOneWidget);
  });
}
