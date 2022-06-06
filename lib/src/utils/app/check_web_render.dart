// ignore_for_file: avoid_print

// import 'dart:js' as js; //este paquete solo puede ser utilizado en aplicaciones web

// importacion condicional :O
import 'mock_dart_js.dart' if (dart.library.js) "dart:js"
    as js; //si se cumple esto , quiere decir que estamos ejecutando el proyecto en la web, sino usaremos dart.js si se esta ejecutando en la web
// si es web usara dart.js, si es movil usara mock dart

bool isHtmlRender() {
  //accedemos al contexto, esto vaa retornar distinto de null si estamos usando canvas kiy sino sera nulo
  final isHtml = js.context['flutterCanvasKit'] == null;
  print("ishtml $isHtml");
  return isHtml;
}

// modos de renderizado - al parecer hacen lo mismo :v
// flutter run -d edge //renderiza en modo canvas
// flutter run -d edge --web-renderer html, se va a renderizan en modo html