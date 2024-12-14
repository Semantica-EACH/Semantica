import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/block/domain/enums/tag.dart';

void toMarkdown(StringBuffer buffer, Block block,
    [int indentLevel = 0, int itemNumber = 1]) {
  String indent = '\t' * indentLevel;
  if (block.tag.name.startsWith('h')) {
    buffer.writeln(
        '${'#' * int.parse(block.tag.name.substring(1))} ${block.header?.textContent}\n');
  } else if (block.tag == Tag.ul) {
    buffer.writeln('$indent- ${block.header?.textContent}');
    indentLevel++;
  } else if (block.tag == Tag.ol) {
    buffer.writeln('$indent$itemNumber. ${block.header?.textContent}');
    indentLevel++;
  } else if (block.tag != Tag.root) {
    buffer.writeln('$indent${block.header?.textContent}');
  }
  for (var child in block.children) {
    toMarkdown(buffer, child, indentLevel, itemNumber);
    if (child.tag == Tag.ol) {
      itemNumber++;
    }
  }
}
