import 'package:code/_res/R.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXSearchBarAppWidget extends StatefulWidget {
  final ValueChanged<String>? onTextChange;
  final Function? onNavBack;
  final Widget? body;
  final String? title;
  final ValueChanged<bool>? onSearching;
  final Widget? floatingActionButton;
  final initSearching;
  final List<Widget> actions;

  const TXSearchBarAppWidget({
    Key? key,
    this.onTextChange,
    this.onNavBack,
    this.body,
    this.title,
    this.onSearching,
    this.floatingActionButton,
    this.initSearching = false,
    this.actions = const [],
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TXSearchBarAppState();
}

class _TXSearchBarAppState extends State<TXSearchBarAppWidget> {
  TextEditingController searchTextController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    searchTextController.text = "";
    isSearching = widget.initSearching ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navBack();
        return false;
      },
      child: Scaffold(
        floatingActionButton: widget.floatingActionButton,
        appBar: AppBar(
          backgroundColor: isSearching
              ? Colors.white
              : null,
          centerTitle: false,
          title: !isSearching
              ? StreamBuilder<TeamTheme>(
                stream: teamThemeController.stream,
                builder: (context, snapshot) {
                  return TXTextWidget(
                      text: widget.title ?? R.string.search,
                      color: snapshot.data?.colors.textColor,
                      size: 18,
                    );
                }
              )
              : TextFormField(
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                      hintText: "${R.string.search}...",
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(vertical: 0)),
                  autofocus: true,
                  controller: searchTextController,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    if (widget.onTextChange != null)
                      widget.onTextChange!(value);
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      isSearching = false;
                      if (widget.onSearching != null)
                        widget.onSearching!(isSearching);
                    });
                  },
                ),
          leading: TXIconButtonWidget(
            icon: Icon(
              isSearching ? Icons.arrow_back : Icons.close,
              color: isSearching ? R.color.grayColor: null,
            ),
            onPressed: () {
              if (widget.onSearching != null) widget.onSearching!(false);
              _navBack();
            },
          ),
          actions: [
            TXIconButtonWidget(
              icon: Icon(
                isSearching ? Icons.close : Icons.search,
                color: isSearching ? R.color.grayColor: null,
              ),
              onPressed: () {
                isSearching = !isSearching;
                setState(() {
                  searchTextController.text = "";
                  if (!isSearching && widget.onSearching != null)
                    widget.onSearching!(isSearching);
                });
              },
            ),
            ...(!isSearching ? widget.actions : [])
          ],
        ),
        body: widget.body,
      ),
    );
  }

  void _navBack() async {
    if (isSearching) {
      setState(() {
        isSearching = false;
      });
    } else {
      widget.onNavBack!();
    }
  }
}
