import 'package:code/_res/R.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXHomeMenuIconWidget extends StatelessWidget {
  final bool isSelected;
  final Widget icon;
  final String text;
  final GestureTapCallback? onTap;
  final Stream<int>? unread;
  final EdgeInsets padding;
  final EdgeInsets iconMargin;

  const TXHomeMenuIconWidget(
      {Key? key,
      this.isSelected = true,
      required this.icon,
      required this.text,
      this.onTap,
      this.unread,
      this.padding = const EdgeInsets.symmetric(horizontal: 3),
      this.iconMargin = const EdgeInsets.all(0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: StreamBuilder<TeamTheme>(
          initialData: R.color.defaultTheme,
          stream: teamThemeController.stream,
          builder: (context, snapshotTheme) {
            return Container(
              width: double.infinity,
              height: 70,
              padding: padding,
              alignment: Alignment.center,
              color: isSelected
                  ? snapshotTheme.data!.colors.sidebarColor
                  : snapshotTheme.data!.colors.secondaryHeaderColor,
              child: unread != null
                  ? Stack(
                      children: [
                        _getMenuIconWidget(isSelected ? snapshotTheme.data!.colors.activeItemText! : snapshotTheme.data!.colors.textColor!),
                        Positioned(
                          right: 5,
                          top: 8,
                          child: StreamBuilder<int>(
                            initialData: 0,
                            stream: unread,
                            builder: (context, snapshot) {
                              return snapshot.data != 0
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              snapshot.data! < 10 ? 7 : 5,
                                          vertical: 3),
                                      decoration: BoxDecoration(
                                        color: snapshotTheme.data!.colors.notificationBadgeBackground,
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 12,
                                        minHeight: 12,
                                      ),
                                      child: new Text(
                                        snapshot.data.toString(),
                                        style: new TextStyle(
                                          color: snapshotTheme.data!.colors.notificationBadgeText,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : Container();
                            },
                          ),
                        )
                      ],
                    )
                  : _getMenuIconWidget(isSelected ? snapshotTheme.data!.colors.activeItemText! : snapshotTheme.data!.colors.textColor!),
            );
          },
        ),
      ),
    );
  }

  Widget _getMenuIconWidget(Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: iconMargin,
          child: icon,
        ),
        SizedBox(
          height: 5,
        ),
        TXTextWidget(
          text: text,
          maxLines: 2,
          textOverflow: TextOverflow.ellipsis,
          color: textColor,
          textAlign: TextAlign.center,
          size: 14,
        ),
      ],
    );
  }
}
