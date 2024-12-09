import 'package:flutter_test/flutter_test.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/block/domain/enums/tag.dart';

void main() {
  group('Block', () {
    test('should create a Block from Markdown with headers', () {
      String markdown = '# Header 1\n## Header 2\n### Header 3';
      Block block = Block.fromMarkdown(markdown);

      expect(block.children.length, 1);
      expect(block.children[0].tag, Tag.h1);
      expect(block.children[0].header?.textContent, 'Header 1');
      expect(block.children[0].children.length, 1);
      expect(block.children[0].children[0].tag, Tag.h2);
      expect(block.children[0].children[0].header?.textContent, 'Header 2');
      expect(block.children[0].children[0].children.length, 1);
      expect(block.children[0].children[0].children[0].tag, Tag.h3);
      expect(block.children[0].children[0].children[0].header?.textContent,
          'Header 3');
    });

    test('should create a Block from Markdown with paragraphs and lists', () {
      String markdown =
          '# Header 1\n\nParagraph 1\n\n- List item 1\n- List item 2';
      Block block = Block.fromMarkdown(markdown);

      expect(block.children.length, 1);
      expect(block.children[0].tag, Tag.h1);
      expect(block.children[0].header?.textContent, 'Header 1');
      expect(block.children[0].children.length, 3);
      expect(block.children[0].children[0].tag, Tag.p);
      expect(block.children[0].children[0].header?.textContent, 'Paragraph 1');
      expect(block.children[0].children[1].tag, Tag.ul);
      expect(block.children[0].children[1].header?.textContent, 'List item 1');
      expect(block.children[0].children[2].tag, Tag.ul);
      expect(block.children[0].children[2].header?.textContent, 'List item 2');
    });

    test(
        'toString should return a formatted string representation of the Block',
        () {
      Block block = Block(
        tag: Tag.h1,
        header: md.Text('Header 1'),
        children: [
          Block(tag: Tag.p, header: md.Text('Paragraph 1')),
          Block(tag: Tag.li, header: md.Text('List item 1')),
        ],
      );

      String expectedString =
          'Block(\n  Tag: h1\n  Header: "Header 1"\n  Block(\n  Tag: p\n  Header: "Paragraph 1")\n  Block(\n  Tag: li\n  Header: "List item 1"))';
      expect(block.toString(), expectedString);
    });
  });
}
