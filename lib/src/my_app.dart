// ignore_for_file: deprecated_member_use
import 'package:delivery_food/src/helpers/dependency_injection.dart';
// import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/routes/pages.dart';
import 'package:delivery_food/src/ui/global_controllers/my_cart_controller.dart';
// import 'package:delivery_food/src/ui/global_controllers/notification_controller.dart';
import 'package:delivery_food/src/utils/colors.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  // convertido a stateful para sobreescribir dispose
  @override
  void dispose() {
    // con dispose liberamos recursos
    DependencyInjection.dispose(); //llamamos al dispose de aca pa cerrar el streamcontroller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //envuelto en un Multiprovider | widget nuevo| tener multiple providers, asi tenemos un estado global y podemos acceder desde cualquier pantallar
    //osea no es una pagina ni nada pero con esto podemos acceder a tal propiedad y metodos desde cualquier lado :O
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyCartController>(
          create: (_) => MyCartController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Delivery App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ThemeData().colorScheme.copyWith(primary: primarycolor), //para que el input tenga nuestro color :D
          accentColor: primarycolor,
          //primaryColor: primarycolor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          //textTheme: GoogleFonts.nunitoTextTheme(), //atodos los text que no tengan style les pone este font
          cupertinoOverrideTheme: CupertinoThemeData(
            //atodos los Cupertext que no tengan style les pone este font
            primaryColor: primarycolor, //atodos los botons su color sera primarycolor
            textTheme: CupertinoTextThemeData(
              textStyle: FontStyles.normal,
            ),
          ),
        ),
        routes: Pages.routes,
        initialRoute: Pages.initial,
        home: Container(),
      ),
    );
  }
}
