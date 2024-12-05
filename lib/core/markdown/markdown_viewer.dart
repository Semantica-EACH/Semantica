import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:semantica/core/markdown/widgets/local_link_builder.dart';
import 'package:markdown/markdown.dart' as md;

/// Visualizador de Markdown reutilizável
class MarkdownViewer extends StatelessWidget {
  final String markdownContent;

  const MarkdownViewer({
    super.key,
    required this.markdownContent,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: markdownContent,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
      extensionSet: md.ExtensionSet([
        ...md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        const md.TableSyntax(),
      ], [
        ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
        md.AutolinkExtensionSyntax(),
      ]),
      builders: {
        'p': LocalLinkBuilder(context: context),
        'li': LocalLinkBuilder(context: context),
        'ol': LocalLinkBuilder(context: context),
        'ul': LocalLinkBuilder(context: context),
        'h1': LocalLinkBuilder(context: context),
        'h2': LocalLinkBuilder(context: context),
        'h3': LocalLinkBuilder(context: context),
        'h4': LocalLinkBuilder(context: context),
        'h5': LocalLinkBuilder(context: context),
        'h6': LocalLinkBuilder(context: context),
      },
    );
  }
}
