import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:semantica/core/utils/preferences_util.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:markdown/markdown.dart' as md;
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:provider/provider.dart';
import 'package:semantica/features/pages/domain/entities/page.dart' as my_page;

class LocalLinkBuilder extends MarkdownElementBuilder {
  final BuildContext context;

  LocalLinkBuilder({required this.context});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final textContent = element.textContent;
    final regex = RegExp(r'\[\[(.*?)\]\]');
    final matches = regex.allMatches(textContent);

    if (matches.isEmpty) {
      return Text(textContent, style: preferredStyle);
    }

    final spans = <TextSpan>[];
    int lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(
            TextSpan(text: textContent.substring(lastMatchEnd, match.start)));
      }

      final matchedText = match.group(1);
      spans.add(
        TextSpan(
          text: '[$matchedText]',
          style: TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final repositoryPath =
                  await PreferencesUtil.getString('repository');
              if (repositoryPath != null) {
                final filePath = path.join(repositoryPath, matchedText);
                if (await File(filePath).exists()) {
                  final page = my_page.Page(
                    path: filePath,
                    title: matchedText!,
                    timestamp: DateTime.now(),
                    metadata: [],
                    content: await File(filePath).readAsString(),
                  );
                  if (context.mounted) {
                    final componentCubit = context.read<ComponentCubit>();
                    componentCubit.openComponent(page);
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Arquivo não encontrado: $filePath')),
                    );
                  }
                }
              }
            },
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < textContent.length) {
      spans.add(TextSpan(text: textContent.substring(lastMatchEnd)));
    }

    return RichText(text: TextSpan(children: spans, style: preferredStyle));
  }
}
