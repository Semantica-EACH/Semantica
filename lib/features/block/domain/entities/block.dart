import 'package:markdown/markdown.dart' as md;
import 'package:semantica/features/block/domain/enums/tag.dart';
import 'package:semantica/features/block/domain/services/from_markdown.dart';
import 'package:semantica/features/block/domain/services/to_markdown.dart'
    as to_md;

class Block {
  Tag tag;
  md.Text? header;
  List<Block> children;

  Block({required this.tag, this.header, List<Block>? children})
      : children = children ?? [];

  Block.root(String? markdown)
      : tag = Tag.root,
        header = null,
        children = markdown != null ? fromMarkdown(markdown) : [];

  Block.fromMarkdown(String markdown)
      : tag = Tag.root,
        children = [] {
    List<Block> parsedBlocks = fromMarkdown(markdown);
    if (parsedBlocks.length > 1) {
      throw Exception('Mais de uma raiz encontrada no Markdown.');
    } else if (parsedBlocks.isEmpty) {
      throw Exception('Nenhuma raiz encontrada no Markdown.');
    } else {
      Block root = parsedBlocks.first;
      tag = root.tag;
      header = root.header;
      children = root.children;
    }
  }

  String toMarkdown() {
    StringBuffer buffer = StringBuffer();
    to_md.toMarkdown(buffer, this);
    return buffer.toString();
  }

  @override
  String toString() {
    return _toStringHelper(0);
  }

  /// Método auxiliar para gerar a string com indentação.
  String _toStringHelper(int indentLevel) {
    final indent = '  ' * indentLevel;
    final childrenStr = children.isNotEmpty
        ? '\n${children.map((child) => child._toStringHelper(indentLevel + 1)).join('\n')}'
        : '';
    return '$indent- tag: $tag\n$indent  header: ${header!.text}${childrenStr.isNotEmpty ? '\n$indent  children:' + childrenStr : ''}';
  }
}
