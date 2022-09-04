import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXMainAppBarWidget extends StatefulWidget {
  final Widget body;
  final String title;
  final bool centeredTitle;
  final TXIconButtonWidget? leading;
  final Function()? onLeadingTap;
  final List<Widget> actions;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool hideLeading;

  const TXMainAppBarWidget(
      {Key? key,
      required this.body,
      this.title = "",
      this.centeredTitle = false,
      this.leading,
      this.actions = const [],
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.onLeadingTap,
      this.hideLeading = false})
      : super(key: key);

  @override
  State<TXMainAppBarWidget> createState() => _TXMainAppBarWidgetState();
}

class _TXMainAppBarWidgetState extends State<TXMainAppBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      appBar: AppBar(
        centerTitle: widget.centeredTitle,
        leading: widget.hideLeading
            ? Container()
            : widget.leading ??
                TXIconButtonWidget(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 30,
                  ),
                  onPressed: widget.onLeadingTap ??
                      () {
                        NavigationUtils.pop(context);
                      },
                ),
        title: StreamBuilder<TeamTheme>(
          stream: teamThemeController.stream,
          builder: (context, snapshot) {
            return TXTextWidget(
              text: widget.title,
              color: snapshot.data?.colors.textColor,
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
              size: 20,
            );
          }
        ),
        actions: widget.actions,
      ),
      body: widget.body,
    );
  }
}
