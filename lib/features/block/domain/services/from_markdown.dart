import 'package:markdown/markdown.dart' as md;
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/block/domain/enums/tag.dart';

List<Block> fromMarkdown(String markdown) {
  List<md.Node> nodes = md.Document().parseLines(markdown.split('\n'));
  return _buildHierarchy(nodes);
}

List<Block> _buildHierarchy(List<md.Node> nodes) {
  Block root = Block(tag: Tag.root, children: []);
  List<Block> stack = [root]; // Pilha para gerenciar a hierarquia de blocos

  for (var node in nodes) {
    if (node is md.Element) {
      String tagStr = node.tag;
      Tag tag = TagExtension.fromString(tagStr); // Convertendo String para Tag

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
        stack.last.children.addAll(_processList(node.children!, tag));
      } else if (node is md.Text) {
        // Processar texto fora de elementos
        Block textBlock = Block(tag: Tag.p, header: node as md.Text);
        stack.last.children.add(textBlock);
      }
    }
  }

  return root.children;
}

/// Processa itens de lista recursivamente
List<Block> _processList(List<md.Node> items, Tag tag) {
  final result = <Block>[];

  for (var item in items) {
    if (item is md.Element && item.tag == 'li') {
      _processListItem(item, result, tag);
    }
  }
  return result;
}

/// Processa um único item de lista (<li>) e o converte em um bloco.
void _processListItem(md.Element item, List<Block> result, Tag tag) {
  // Obtém o texto do item ignorando sublistas
  final md.Text itemText = _findFirstTextElement(item);

  // Verifica se há sublistas (<ul> ou <ol>)
  final md.Element? sublist = _findSublistElement(item);

  Tag? childrenTag =
      sublist != null ? TagExtension.fromString(sublist.tag) : null;

  List<Block> children = sublist != null && sublist.children!.isNotEmpty
      ? _processList(sublist.children!, childrenTag!)
      : [];

  result.add(
    Block(
      tag: tag,
      header: itemText,
      children: children,
    ),
  );
}

md.Text _findFirstTextElement(md.Element item) =>
    item.children?.whereType<md.Text>().firstOrNull ?? md.Text('');

md.Element? _findSublistElement(md.Element item) => item.children
    ?.where((child) =>
        child is md.Element && (child.tag == 'ul' || child.tag == 'ol'))
    .firstOrNull as md.Element?;
