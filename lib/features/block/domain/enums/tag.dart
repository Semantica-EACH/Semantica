enum Tag { root, h1, h2, h3, h4, h5, h6, p, li, ul, ol }

extension TagExtension on Tag {
  // Método auxiliar para converter de String para Tag
  static Tag fromString(String tag) {
    switch (tag) {
      case 'h1':
        return Tag.h1;
      case 'h2':
        return Tag.h2;
      case 'h3':
        return Tag.h3;
      case 'h4':
        return Tag.h4;
      case 'h5':
        return Tag.h5;
      case 'h6':
        return Tag.h6;
      case 'p':
        return Tag.p;
      case 'li':
        return Tag.li;
      case 'ul':
        return Tag.ul;
      case 'ol':
        return Tag.ol;
      default:
        throw ArgumentError('Tag desconhecido: $tag');
    }
  }

  // Método para verificar se a tag é um cabeçalho
  bool isHeader() {
    return this == Tag.h1 ||
        this == Tag.h2 ||
        this == Tag.h3 ||
        this == Tag.h4 ||
        this == Tag.h5 ||
        this == Tag.h6;
  }

  // Método para retornar o nível do cabeçalho
  int? headerLevel() {
    if (isHeader()) {
      return int.parse(toString().substring(5));
    }
    return null;
  }

  // Método para verificar se a tag é um item de lista
  bool isListItem() {
    return this == Tag.li || this == Tag.ul || this == Tag.ol;
  }
}
