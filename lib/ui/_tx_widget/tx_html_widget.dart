import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class TXHtmlWidget extends StatelessWidget {
  final String body;
  final Map<String, Style> style;
  final bool shrinkWrap;
  final ValueChanged<String>? onLinkTap;

  const TXHtmlWidget({
    Key? key,
    required this.body,
    required this.style,
    this.shrinkWrap = false,
    this.onLinkTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Html(
        data: body,
        style: style,
        shrinkWrap: shrinkWrap,
        onAnchorTap: _linkTap,
        onLinkTap: _linkTap,
      );

  void _linkTap(String? link, RenderContext context, Map<String, String> map,
      dom.Element? element) {
    if(link?.isNotEmpty == true) {
      appLinksContentController.sinkAddSafe(AppLinksNavigationModel(link: link!, onLinkTap: onLinkTap));
    }
  }
}
