// ignore_for_file: avoid_print

import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:flutter_test/flutter_test.dart';

// cuando ejecutamos todos los test va a seguir ejecutando aunque un test tenga error
void main() {
  // se ejecutara al principio, se usa mas para inicializar variables, declarar constantes etc
  setUpAll(() {
    print("jaja xd setupAll");
  });
  //se ejecutara al final todos los grupos, al final, teardownAll, muestre tal codigo (claro de este archivo)
  tearDownAll(() {
    print("jaja xd tearDownAll");
  });

// hacer un grupo de test con group, no a cambiar en nada el funcionamiento, simplemente podremos ejecutall tal grupo, setup y teardown se ejecutan dentro un grupo
  group('Get-tests', () {
    // funcion setUp,  de callback, va a iniciar esta funcion cada ves antes de que inicie un test, puede ser util por ejemplo para limpiar datos residuales de los test
    // tambien soporta ejecucion asicrona
    setUp(() {
      print("data removed ${Get.i.clear()}");
      print("lazydara removed ${Get.i.clearLazy()}");
    });
    // tearDown funciona de forma inversa a setup, se ejecuta despues de cada test, ejecutar algun codigo despues de que el test termine
    // tambien soporta ejecucion asincrona
    tearDown(() async {
      await Future.delayed(const Duration(seconds: 1));
      print("◘");
    });

    // test q comprueba el get, q efectivamente si el dato no existe en nuestras dependencias devuelva un assertionError
    test('Get-isassertionError', () {
      bool catchCalled = false;
      try {
        Get.i.find<String>(tag: "apikey");
      } catch (e) {
        // expect(e, isA<AssertionError>()); //isA es de flutter test
        // expect(e, isAssertionError); //forma2
        if (e is AssertionError) {
          catchCalled = true;
        }
      }
      expect(catchCalled, true); //probamos
      catchCalled = false; //volvemos a poner a false

      try {
        Get.i.find<String>();
      } catch (e) {
        // expect(e, isA<AssertionError>()); //isA es de flutter test
        // expect(e, isAssertionError); //forma2

        if (e is AssertionError) {
          catchCalled = true;
        }
      }

      expect(catchCalled, true);
      catchCalled = false;

      try {
        Get.i.find<User>(lazy: true);
      } catch (e) {
        if (e is AssertionError) {
          catchCalled = true;
        }
      }
      expect(catchCalled, true);
      catchCalled = false;

      try {
        Get.i.find<User>(lazy: true, tag: 'user'); //seguimos probando ahora con un tag cualquiera
      } catch (e) {
        if (e is AssertionError) {
          catchCalled = true;
        }
      }
      expect(catchCalled, true);
      print("▲ Get isassertionError");
    });

    test('Get-put-find API_KEY remove', () {
      // print("▲ Get find API_KEY remove");
      // para ponerle un Teardown especifico a este test, teardown se ejecutara despues del test
      addTearDown(() {
        print("▲ despues del put, Get find API_KEY remove");
      });

      Get.i.put<String>("API_KEY", tag: "apikey");
      Get.i.put<String>("GOOGLE_MAPS_API_KEY");

      bool userCreated = true;
      Get.i.lazyPut<User>(
        () {
          userCreated = true;
          return User(
            id: '126309',
            name: "juan",
            email: "test@test.com",
            lastname: "Osi",
            cumple: DateTime(1993, 12, 1),
          );
        },
      );
      //probando el lazy put con un tag
      int counter2 = 0;
      Get.i.lazyPut<User>(() {
        counter2++;
        return User(
          id: '126308',
          name: "juan",
          email: "test@test.com",
          lastname: "Osi",
          cumple: DateTime(1993, 12, 1),
        );
      }, tag: 'user2');

      Get.i.find<User>(lazy: true);
      expect(userCreated, true);

      final user1 = Get.i.find<User>(lazy: true);
      expect(userCreated, true);

      //probando el find con tag
      final user2 = Get.i.find<User>(lazy: true, tag: 'user2');
      expect(user1.id != user2.id, true); //1

      final apikey = Get.i.find<String>(tag: "apikey");
      expect(apikey, "API_KEY");
      final apikey2 = Get.i.find<String>();
      expect(apikey2, "GOOGLE_MAPS_API_KEY");

      // try {
      //   Get.i.find<String>();
      // } catch (e) {
      //   expect(e, isAssertionError);
      // }
      expect(Get.i.removee<String>(), true);
      expect(Get.i.removee<String>(tag: "apikey"), true);
      expect(Get.i.removee<User>(), true);
      expect(Get.i.removee<User>(tag: 'user2'), true);
      Get.i.find<User>(lazy: true, tag: 'user2');
      expect(counter2, 2); //es 2 pk hacemos dos finds a user2

      Get.i.find<User>(lazy: true, tag: 'user2');
      expect(counter2, 2); //es 2 pk hacemos dos finds a user2

      // Get.i.find<User>(lazy: true);
      Get.i.put<String>("GOOGLE_MAPS_API_KEY"); //ejemplo lo volvemos a poner
    });

    // test q solo tiene que ver con lazy put
    test('lazyput, lazy find test', () {
      bool userCreated = true;
      Get.i.lazyPut<User>(
        () {
          userCreated = true;
          return User(
            id: '126309',
            name: "juan",
            email: "test@test.com",
            lastname: "Osi",
            cumple: DateTime(1993, 12, 1),
          );
        },
      );
      //probando el lazy put con un tag
      int counter2 = 0;
      Get.i.lazyPut<User>(() {
        counter2++;
        return User(
          id: '126308',
          name: "juan",
          email: "test@test.com",
          lastname: "Osi",
          cumple: DateTime(1993, 12, 1),
        );
      }, tag: 'user2');

      Get.i.find<User>(lazy: true);
      expect(userCreated, true);

      final user1 = Get.i.find<User>(lazy: true);
      expect(userCreated, true);

      //probando el find con tag
      final user2 = Get.i.find<User>(lazy: true, tag: 'user2');
      expect(user1.id != user2.id, true); //1

      expect(Get.i.removee<User>(), true);
      expect(Get.i.removee<User>(tag: 'user2'), true);
      Get.i.find<User>(lazy: true, tag: 'user2');
      expect(counter2, 2); //es 2 pk hacemos dos finds a user2

      Get.i.find<User>(lazy: true, tag: 'user2');
      expect(counter2, 2); //es 2 pk hacemos dos finds a user2

      // final googleMapsApiKey = Get.i.find<String>();
      // print(googleMapsApiKey); // y asi con esto podemos ver q si podemos traer datos de otro test
      print("fin");
    });
  });

// si tenemos test que estan relacionados podemos agrupar test
// si se empiezar a perder la logica de tal test, lo mejor es subdividirlo para que sea man entendible

  group('Get clear && lazyclear', () {
    // vaciamos los datos con tearDown, se ejecutara al fina de cada test
    tearDown(() {
      Get.i.clear();
      Get.i.clearLazy();
    });
    test('clear', () {
      expect(Get.i.clear(), 0); //retornaria 0 pk recordermos q clear esta vacio
      Get.i.put<String>("GOOGLE_MAPS_API_KEY");
      expect(Get.i.clear(), 1);
    });

    test('lazy-clear', () {
      expect(Get.i.clearLazy(), 0);
      // inyectamos una dependencia con lazyput
      Get.i.lazyPut<String>(
        () {
          return DateTime.now().toString();
        },
      );
      expect(Get.i.clearLazy(), 1);
    });
  });
}
