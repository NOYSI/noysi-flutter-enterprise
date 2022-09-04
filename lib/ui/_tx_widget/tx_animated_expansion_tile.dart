import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../_res/R.dart';

const Duration _kExpand = Duration(milliseconds: 300);

class TXAnimatedExpansionTile extends StatefulWidget {
  const TXAnimatedExpansionTile({
    super .key,
    this.leading,
    required this.title,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.topParentContainerBorder = true,
    this.bottomParentContainerBorder = true,
    this.expandedBottomContainerBorder = true,
    this.hideSubtitleOnExpanded = false,
    this.padding,
    this.chevronPadding,
    this.subtitle,
    this.chevronColor
  });

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Color? backgroundColor, chevronColor;
  final Widget? trailing;
  final bool initiallyExpanded;
  final bool topParentContainerBorder;
  final bool bottomParentContainerBorder;
  final bool expandedBottomContainerBorder;
  final EdgeInsetsGeometry? padding, chevronPadding;
  final bool hideSubtitleOnExpanded;

  @override
  State<StatefulWidget> createState() => _TXAnimatedExpansionTileState();

}

class _TXAnimatedExpansionTileState extends State<TXAnimatedExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _easeOutAnimation;
  late CurvedAnimation _easeInAnimation;
  late ColorTween _borderColor;
  late ColorTween _headerColor;
  late ColorTween _iconColor;
  late ColorTween _backgroundColor;
  late Animation<double> _iconTurns;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation =
    CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation =
    CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor = ColorTween();
    _headerColor = ColorTween();
    _iconColor = ColorTween();
    _iconTurns =
        Tween<double>(begin: 0.5, end: 0.0).animate(_easeInAnimation);
    _backgroundColor = ColorTween();

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(!_isExpanded);
  }

  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse().then<void>((dynamic value) {
            setState(() {
              // Rebuild without widget.children.
            });
          });
        }
        PageStorage.of(context)?.writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged!(_isExpanded);
      }
    }
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color borderSideColor =
        _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;

    return Container(
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: widget.topParentContainerBorder
                    ? _borderColor.evaluate(_easeInAnimation) ?? Colors.transparent
                    : Colors.transparent),
            bottom: BorderSide(
                color: widget.bottomParentContainerBorder
                    ? _borderColor.evaluate(_easeInAnimation) ?? Colors.transparent
                    : Colors.transparent),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: toggle,
            child: Container(
              padding: widget.padding ??
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: _backgroundColor.evaluate(_easeOutAnimation) ??
                      Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                        color: widget.expandedBottomContainerBorder
                            ? borderSideColor
                            : Colors.transparent),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            widget.leading ?? Container(),
                            Expanded(child: widget.title),
                          ],
                        ),
                      ),
                      widget.trailing ?? Padding(
                          padding: widget.chevronPadding ?? const EdgeInsets.only(right: 15),
                          child: RotationTransition(
                            turns: _iconTurns,
                            child: SvgPicture.asset(R.image.chevronUp, color: widget.chevronColor),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: (widget.hideSubtitleOnExpanded && _isExpanded) ||
                        widget.subtitle == null
                        ? 0
                        : 14,
                  ),
                  (widget.hideSubtitleOnExpanded && _isExpanded) ||
                      widget.subtitle == null
                      ? Container()
                      : widget.subtitle!
                ],
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _easeInAnimation.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _borderColor.end = theme.dividerColor;
    _headerColor
      ..begin = theme.textTheme.subtitle1?.color ?? theme.colorScheme.secondary
      ..end = theme.colorScheme.secondary;
    _iconColor
      ..begin = theme.unselectedWidgetColor
      ..end = theme.colorScheme.secondary;
    _backgroundColor.end = widget.backgroundColor;

    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}