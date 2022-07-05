import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TXPullToRefreshWidget extends StatefulWidget {
  final Widget body;
  final ValueChanged<RefreshController>? onRefresh;
  final ValueChanged<RefreshController>? onLoadMore;

  const TXPullToRefreshWidget({
    Key? key,
    required this.body,
    this.onRefresh,
    this.onLoadMore,
  }) : super(key: key);

  @override
  _TXPullToRefreshWidgetState createState() => _TXPullToRefreshWidgetState();
}

class _TXPullToRefreshWidgetState extends State<TXPullToRefreshWidget> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: CustomHeader(
        builder: (BuildContext context, RefreshStatus? mode) {
          return Container(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? status) {
          return Container(
            child: CupertinoActivityIndicator(),
          );
        },
        loadStyle: LoadStyle.ShowWhenLoading,
      ),
      controller: _refreshController,
      onRefresh: () {
        widget.onRefresh!(_refreshController);
      },
      onLoading: () {
        widget.onLoadMore!(_refreshController);
      },
      child: widget.body,
    );
  }
}
