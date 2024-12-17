import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    Key? key,
    this.leading,
    required this.title,
    this.backgroundColor,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.tilePadding,
  }) : super(key: key);

  final Widget? leading;
  final Widget title;
  final List<Widget> children;
  final Color? backgroundColor;
  final Widget? trailing;
  final bool initiallyExpanded;
  final EdgeInsetsGeometry? tilePadding;

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 1);

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late bool _isExpanded = widget.initiallyExpanded;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
    });
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final bool hasChildren = widget.children.isNotEmpty;

    EdgeInsetsGeometry padding = widget.tilePadding ?? EdgeInsets.zero;
    if (!hasChildren) {
      padding = padding.add(const EdgeInsets.only(left: 24.0));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: widget.backgroundColor,
          padding: padding,
          child: Row(
            children: [
              hasChildren
                  ? GestureDetector(
                      onTap: _handleTap,
                      child: RotationTransition(
                        turns: _iconTurns,
                        child: widget.trailing ??
                            Icon(
                              _isExpanded
                                  ? Icons.expand_more
                                  : Icons.chevron_right,
                              color: Theme.of(context).iconTheme.color,
                            ),
                      ),
                    )
                  : SizedBox.shrink(),
              if (widget.leading != null) widget.leading!,
              Expanded(child: widget.title),
            ],
          ),
        ),
        ClipRect(
          child: Align(
            heightFactor: _heightFactor.value,
            child: child,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}
