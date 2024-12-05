import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:semantica/core/utils/preferences_util.dart';
import 'package:path/path.dart' as path;
import 'package:semantica/features/pages/domain/services/page_open.dart';

class TodoElementBuilder extends MarkdownElementBuilder {
  final BuildContext context;

  TodoElementBuilder({required this.context});

  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    final textContent = text.text;
    final regex = RegExp(r'\[\[(.*?)\]\]');
    final matches = regex.allMatches(textContent);

    if (matches.isEmpty) {
      return Text(textContent, style: preferredStyle);
    }

    return _buildRichText(textContent, matches, preferredStyle);
  }

  RichText _buildRichText(String textContent, Iterable<RegExpMatch> matches,
      TextStyle? preferredStyle) {
    final spans = <InlineSpan>[];
    int lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(
            TextSpan(text: textContent.substring(lastMatchEnd, match.start)));
      }

      final matchedText = match.group(1);
      spans.add(_buildClickableSpan(matchedText, preferredStyle));

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < textContent.length) {
      spans.add(TextSpan(text: textContent.substring(lastMatchEnd)));
    }

    return RichText(text: TextSpan(children: spans, style: preferredStyle));
  }

  WidgetSpan _buildClickableSpan(
      String? matchedText, TextStyle? preferredStyle) {
    return WidgetSpan(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _openPage(matchedText),
          child: Text(
            matchedText!,
            style: preferredStyle?.copyWith(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Future<void> _openPage(String? matchedText) async {
    final repositoryPath = await PreferencesUtil.getString('repository');
    if (repositoryPath != null) {
      final filePath = path.join(repositoryPath, '${matchedText!}.md');
      if (context.mounted) {
        await openPageComponent(
          context: context,
          filePathOrName: filePath,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Caminho completo: $filePath')),
        );
      }
    }
  }
}
