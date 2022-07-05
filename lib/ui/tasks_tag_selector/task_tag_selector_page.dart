import 'package:code/_res/R.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_search_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/tasks_tag_create_edit/tasks_tag_create_edit_page.dart';
import 'package:code/ui/tasks_tag_selector/task_tag_selector_bloc.dart';
import 'package:flutter/material.dart';

class TaskTagSelectorPage extends StatefulWidget {
  final List<TaskLabelModel> selectedList;
  final String channelId;

  const TaskTagSelectorPage({Key? key, this.selectedList = const [], required this.channelId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskTagSelectorState();
}

class _TaskTagSelectorState
    extends StateWithBloC<TaskTagSelectorPage, TaskTagSelectorBloC> {

  @override
  void initState() {
    super.initState();
    bloc.loadTags(widget.channelId);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return TXSearchBarAppWidget(
      onNavBack: () {
        NavigationUtils.pop(context);
      },
      title: R.string.tags,
      onTextChange: (value) {
        bloc.query(value);
      },
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: R.color.whiteColor,),
        backgroundColor: R.color.secondaryColor,
        onPressed: () async {
          final res = await NavigationUtils.push(context, TasksTagCreateEditPage(
            previewName: bloc.currentQuery,
            channelId: widget.channelId,
          ));
          if((res is TaskLabelModel)){
            NavigationUtils.pop(context, result: res);
          }
        },
      ),
      body: Container(
        child: StreamBuilder<List<TaskLabelModel>>(
            stream: bloc.taskLabelResult,
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.data!.isEmpty && bloc.currentQuery.isEmpty)
                return Container();
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 60),
                itemBuilder: (ctx, index) {
                  final label = snapshot.data![index];
                  String backgroundColor =
                      label.background.split("#").last;
                  return Container(
                    height: 45,
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              NavigationUtils.pop(context,
                                  result: label);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: Color(int.tryParse(
                                            '0xFF$backgroundColor') ??
                                            int.parse(
                                                '0xFF9A2FAE')),
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(
                                                4))),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: TXTextWidget(
                                      text: label.name,
                                      color: R.color.blackColor,
                                    ),
                                  ),
                                  widget.selectedList
                                      .map((e) => e.id)
                                      .toList()
                                      .contains(label.id)
                                      ? Icon(
                                    Icons
                                        .check_circle_outline,
                                    size: 15,
                                    color:
                                    R.color.secondaryColor,
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                        TXDividerWidget()
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            }),
      ),
    );
  }
}
