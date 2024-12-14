import 'package:flutter_test/flutter_test.dart';
//import 'package:markdown/markdown.dart' as md;
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/block/domain/enums/tag.dart';
import 'package:semantica/features/block/domain/services/from_markdown.dart';

void main() {
  group('fromMarkdown', () {
    test('should parse headers correctly', () {
      String markdown = '# Header 1\n## Header 2\n### Header 3';
      List<Block> blocks = fromMarkdown(markdown);

      expect(blocks.length, 1);
      expect(blocks[0].tag, Tag.h1);
      expect(blocks[0].children.length, 1);
      expect(blocks[0].children[0].tag, Tag.h2);
      expect(blocks[0].children[0].children.length, 1);
      expect(blocks[0].children[0].children[0].tag, Tag.h3);
    });

    test('should parse paragraphs correctly', () {
      String markdown = 'This is a paragraph.\n\nThis is another paragraph.';
      List<Block> blocks = fromMarkdown(markdown);

      expect(blocks.length, 2);
      expect(blocks[0].tag, Tag.p);
      expect(blocks[0].header!.text, 'This is a paragraph.');
      expect(blocks[1].tag, Tag.p);
      expect(blocks[1].header!.text, 'This is another paragraph.');
    });

    test('should parse unordered lists correctly', () {
      String markdown = '- Item 1\n- Item 2\n- Item 3';
      List<Block> blocks = fromMarkdown(markdown);

      expect(blocks.length, 3);
      expect(blocks[0].tag, Tag.ul);
      expect(blocks[0].header!.text, 'Item 1');
      expect(blocks[1].tag, Tag.ul);
      expect(blocks[1].header!.text, 'Item 2');
      expect(blocks[2].tag, Tag.ul);
      expect(blocks[2].header!.text, 'Item 3');
    });

    test('should parse ordered lists correctly', () {
      String markdown = '1. Item 1\n2. Item 2\n3. Item 3';
      List<Block> blocks = fromMarkdown(markdown);

      expect(blocks.length, 3);
      expect(blocks[0].tag, Tag.ol);
      expect(blocks[0].header!.text, 'Item 1');
      expect(blocks[1].tag, Tag.ol);
      expect(blocks[1].header!.text, 'Item 2');
      expect(blocks[2].tag, Tag.ol);
      expect(blocks[2].header!.text, 'Item 3');
    });

    test('should parse nested lists correctly', () {
      String markdown =
          '- Item 1\n\t1. Subitem 1.1\n\t2. Subitem 1.2\n\t\t- Subitem 1.2.1\n- Item 2';

      List<Block> blocks = fromMarkdown(markdown);

      expect(blocks.length, 2);
      expect(blocks[0].tag, Tag.ul);
      expect(blocks[0].header!.text, 'Item 1');
      expect(blocks[0].children.length, 2);
      expect(blocks[0].children[0].tag, Tag.ol);
      expect(blocks[0].children[0].header!.text, 'Subitem 1.1');
      expect(blocks[0].children[1].tag, Tag.ol);
      expect(blocks[0].children[1].header!.text, 'Subitem 1.2');
      expect(blocks[0].children[1].children[0].tag, Tag.ul);
      expect(blocks[0].children[1].children[0].header!.text, 'Subitem 1.2.1');
      expect(blocks[1].tag, Tag.ul);
      expect(blocks[1].header!.text, 'Item 2');
    });
  });
}
