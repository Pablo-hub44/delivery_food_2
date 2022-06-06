class OnboardItem {
  final String image, title, description;

  OnboardItem({
    required this.image,
    required this.title,
    required this.description,
  }) {
    //le vamos a poner validaciones a la clase con assert para que se instancie sin q halla errores :D
    // ya no necesario por null safety usado
    assert(image.contains(".svg")); //q no sea nulo y contenga .svg
    // assert(title != null);
    // assert(description != null);
  }
}
