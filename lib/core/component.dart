abstract class Component {
  final String id;
  final String name;

  Component({required this.id, required this.name});

  // Método abstrato que será implementado pelas subclasses
  Map<String, dynamic> render();
}
