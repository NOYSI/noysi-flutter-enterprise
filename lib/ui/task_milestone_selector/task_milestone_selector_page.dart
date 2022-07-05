import 'package:code/_res/R.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_search_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/task_milestone_create_edit/task_milestone_create_edit_page.dart';
import 'package:code/ui/task_milestone_selector/task_milestone_selector_bloc.dart';
import 'package:flutter/material.dart';

class TaskMilestoneSelectorPage extends StatefulWidget {
  final TaskMileStoneModel? selectedMilestone;
  final String channelId;

  const TaskMilestoneSelectorPage(
      {Key? key, this.selectedMilestone, required this.channelId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskMilestoneSelectorState();
}

class _TaskMilestoneSelectorState extends StateWithBloC<
    TaskMilestoneSelectorPage, TaskMilestoneSelectorBloC> {
  @override
  void initState() {
    super.initState();
    bloc.loadMilestones(widget.channelId);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return TXSearchBarAppWidget(
      onNavBack: () {
        NavigationUtils.pop(context);
      },
      title: R.string.milestones,
      onTextChange: (value) {
        bloc.query(value);
      },
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: R.color.whiteColor,),
        backgroundColor: R.color.secondaryColor,
        onPressed: () async {
          final res = await NavigationUtils.push(
              context,
              TaskMilestoneCreateEditPage(
                previewName: bloc.currentQuery,
                channelId: widget.channelId,
              ));
          if ((res is TaskMileStoneModel)) {
            NavigationUtils.pop(context, result: res);
          }
        },
      ),
      body: Container(
        child: StreamBuilder<List<TaskMileStoneModel>>(
            stream: bloc.milestonesResult,
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.data!.isEmpty && bloc.currentQuery.isEmpty)
                return Container();
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 60),
                itemBuilder: (ctx, index) {
                  final milestone = snapshot.data![index];
                  return Container(
                    height: 45,
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              NavigationUtils.pop(context, result: milestone);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TXTextWidget(
                                      text: milestone.title,
                                      color: R.color.blackColor,
                                    ),
                                  ),
                                  widget.selectedMilestone?.id == milestone.id
                                      ? Icon(
                                          Icons.check_circle_outline,
                                          size: 15,
                                          color: R.color.secondaryColor,
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
