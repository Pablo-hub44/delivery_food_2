class Category {
  final String iconPath;
  final String label;

  Category({
    required this.iconPath,
    required this.label,
  }) {
    //le vamos a poner validaciones a la clase con assert para que se instancie sin q halla errores :D
    assert(iconPath.contains(".svg")); //q iconpath no sea nulo y que sea .svg
    // assert(label != null);
    // ya no es necesario validar si el nulo, pk le ponemos required
  }
}
