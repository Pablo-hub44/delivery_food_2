//las fuentes de texto
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FontStyles {
  //FontStyles pa solo llamarlo con FontStyles, nuestras fuentes del paquete googlefonts
  static final TextTheme textTheme = GoogleFonts.nunitoTextTheme(); //ponerle una tipografia en general

  static final titulo = GoogleFonts.roboto(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  static final normal = GoogleFonts.nunito(
    fontWeight: FontWeight.w400,
  );

  static final normalnegrito = GoogleFonts.nunito(
    fontWeight: FontWeight.w600,
  );
}
