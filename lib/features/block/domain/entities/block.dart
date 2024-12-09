import 'package:markdown/markdown.dart' as md;
import '../enums/tag.dart';

class Block {
  Tag tag;
  md.Text? header;
  List<Block> children;

  Block({required this.tag, this.header, List<Block>? children})
      : children = children ?? [];

  Block.fromMarkdown(String markdown)
      : tag = Tag.root,
        header = null,
        children =
            _buildHierarchy(md.Document().parseLines(markdown.split('\n')));

  static List<Block> _buildHierarchy(List<md.Node> nodes) {
    Block root = Block(tag: Tag.root, children: []);
    List<Block> stack = [root]; // Pilha para gerenciar a hierarquia de blocos

    for (var node in nodes) {
      if (node is md.Element) {
        String tagStr = node.tag;
        Tag tag =
            TagExtension.fromString(tagStr); // Convertendo String para Tag

        // Captura o conteúdo como um md.Text ou null
        md.Text? headerText;
        if (node.children!.isNotEmpty && node.children!.first is md.Text) {
          headerText = node.children!.first as md.Text;
        }

        if (tag.name.startsWith('h')) {
          // Processar cabeçalhos (h1, h2, etc.)
          int level = int.parse(tag.name.substring(1));

          // Encontrar o pai adequado na pilha
          while (stack.length > level) {
            stack.removeLast();
          }

          // Criar um novo bloco e adicioná-lo ao pai atual
          Block headerBlock = Block(tag: tag, header: headerText);
          stack.last.children.add(headerBlock);

          // Adicionar o novo bloco à pilha
          stack.add(headerBlock);
        } else if (tag == Tag.p) {
          // Processar parágrafos
          Block paragraphBlock = Block(tag: tag, header: headerText);
          stack.last.children.add(paragraphBlock);
        } else if (tag == Tag.ul || tag == Tag.ol) {
          // Processar listas
          _processListItems(node, stack, tag);
        } else if (node is md.Text) {
          // Processar texto fora de elementos
          Block textBlock = Block(tag: Tag.p, header: node as md.Text);
          stack.last.children.add(textBlock);
        }
      }
    }

    return root.children;
  }

  static void _processListItems(md.Element node, List<Block> stack, Tag tag) {
    for (var child in node.children!) {
      if (child is md.Element && child.tag == 'li') {
        Block listItemBlock = Block(
            tag: tag,
            header: child.children!.isNotEmpty
                ? child.children?.first as md.Text
                : null);
        stack.last.children.add(listItemBlock);
      }
    }
  }

  @override
  String toString() {
    String headerContent = header?.textContent ?? '';
    String childrenString =
        children.map((child) => child.toString()).join('\n  ');
    return 'Block(\n  Tag: ${tag.name}\n  Header: "$headerContent"${children.isNotEmpty ? '\n  ' + childrenString : ''})';
  }
}
