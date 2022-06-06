// ignore_for_file: avoid_print

import 'package:delivery_food/src/utils/date_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // agrupado :D, no es necesario que este agrupado xd
  group('dateFormats', () {
    test('Date format test', () {
      print("▲ date format test");
      DateTime date = DateTime(2022, 1, 1);
      // para probar un codigo es con expect (el valor actual q queremos probar, el valor q queremos q sea) si no es dara error
      expect(date.format, "01/01/2022");

      date = DateTime(2022, 11, 2);
      expect(date.format, "02/11/2022");

      date = DateTime(2022, 1, 2);
      expect(date.format, "02/01/2022");

      date = DateTime(2022, 1, 15);
      expect(date.format, "15/01/2022");
    });
    // asi cubrimos todos los casos que tendria q funcionar, y si no que de error
    // otro test de que el mes sea menor a 10, testeandolos de forma separada
    test('month < 10', () {
      DateTime date = DateTime(2012, 1, 20);
      expect(date.format, "20/01/2012");
    });

    test('day < 10', () {
      DateTime date = DateTime(2012, 1, 9);
      expect(date.format, "09/01/2012");
    });

    test('day < 10 && month < 10', () {
      DateTime date = DateTime(2012, 9, 9);
      expect(date.format, "09/09/2012");
    });
  });
}
