import 'package:code/_res/R.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/task/tx_label_widget.dart';
import 'package:code/ui/tasks_tag/tasks_tag_bloc.dart';
import 'package:code/ui/tasks_tag_create_edit/tasks_tag_create_edit_page.dart';
import 'package:flutter/material.dart';

class TasksTagPage extends StatefulWidget {
  final String channelId;

  const TasksTagPage({Key? key, required this.channelId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TasksTagState();
}

class _TasksTagState extends StateWithBloC<TasksTagPage, TaskTagBloc> {
  @override
  void initState() {
    super.initState();
    bloc.loadTags(widget.channelId);

  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        TXMainAppBarWidget(
          title: R.string.tags,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: R.color.whiteColor,),
            backgroundColor: R.color.secondaryColor,
            onPressed: () async {
              final res = await NavigationUtils.push(
                  context,
                  TasksTagCreateEditPage(
                    previewName: "",
                    channelId: widget.channelId,
                  ));
              if (res is TaskLabelModel) {
                bloc.loadTags(widget.channelId);
              }
            },
          ),
          body: Container(
            child: StreamBuilder<List<TaskLabelModel>>(
              stream: bloc.taskLabelResult,
              initialData: [],
              builder: (ctx, snapshot) {
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 60),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final label = snapshot.data![index];
                    return Container(
                      height: 80,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TXLabelWidget(
                                          taskLabelModel: label,
                                        ),
                                        TXTextWidget(
                                          text:
                                              "${label.taskCount} ${R.string.openTasks}",
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      TXIconButtonWidget(
                                        icon: Icon(
                                          Icons.edit,
                                          color: R.color.grayColor,
                                          size: 20,
                                        ),
                                        onPressed: () async {
                                          final res =
                                              await NavigationUtils.push(
                                                  context,
                                                  TasksTagCreateEditPage(
                                                    taskLabelModel: label,
                                                    channelId: widget.channelId,
                                                  ));
                                          if (res is TaskLabelModel) {
                                            bloc.loadTags(widget.channelId);
                                          }
                                        },
                                      ),
                                      TXIconButtonWidget(
                                        icon: Icon(Icons.delete_forever,
                                            color: R.color.grayColor, size: 20),
                                        onPressed: () {
                                          bloc.deleteTag(label);
                                        },
                                      )
                                    ],
                                  )
                                ],
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
              },
            ),
          ),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }
}
