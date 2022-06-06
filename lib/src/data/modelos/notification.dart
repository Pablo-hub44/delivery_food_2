// nuestro modelo de notificacion
class AppNotification {
  final int id;
  final String title, description;
  final dynamic content; //pk las notificacion pueden tener todo tipo de contenido
  final DateTime createdAt;

  // constructor con parametros de nombre
  AppNotification({
    required this.createdAt,
    required this.id,
    required this.title,
    required this.description,
    required this.content,
  });
}
