import 'package:code/_res/R.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_date_selector_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/task_milestone_create_edit/task_milestone_create_edit_bloc.dart';
import 'package:flutter/material.dart';

class TaskMilestoneCreateEditPage extends StatefulWidget {
  final TaskMileStoneModel? taskMileStoneModel;
  final String previewName;
  final String channelId;

  const TaskMilestoneCreateEditPage(
      {Key? key,
      this.taskMileStoneModel,
      this.previewName = '',
      required this.channelId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskMilestoneCreateEditState();
}

class _TaskMilestoneCreateEditState extends StateWithBloC<
    TaskMilestoneCreateEditPage, TaskMilestoneCreateEditBloC> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textDescriptionController = TextEditingController();
  final _keyFormAddEditMilestone = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textEditingController.text = (widget.taskMileStoneModel?.title ??  widget.previewName);
    textDescriptionController.text = widget.taskMileStoneModel?.description ?? "";
    bloc.initViewData(widget.taskMileStoneModel, widget.channelId);
    bloc.addEditMilestoneResult.listen((milestone) {
      NavigationUtils.pop(context, result: milestone);
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        TXMainAppBarWidget(
          title: widget.taskMileStoneModel != null
              ? R.string.editMilestone
              : R.string.createNewMilestone,
          body: Container(
            child: Form(
              key: _keyFormAddEditMilestone,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: StreamBuilder<TaskMileStoneModel>(
                            stream: bloc.initResult,
                            initialData: null,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) return Container();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TXTextWidget(
                                    text: R.string.name,
                                    color: R.color.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  TXTextFieldWidget(
                                    controller: textEditingController,
                                    validator: bloc.required(),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TXTextWidget(
                                    text: R.string.description,
                                    color: R.color.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  TXTextFieldWidget(
                                    controller: textDescriptionController,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TXDateSelectorWidget(
                                    onDateSelected: (date) {
                                      if(date != null) bloc.updateDateTime(date);
                                    },
                                    initialDate: snapshot.data!.due,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                    TXGestureHideKeyBoard(
                      child: Container(
                        width: double.infinity,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          child: TXButtonWidget(
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            title: widget.taskMileStoneModel == null
                                ? R.string.addMilestone
                                : R.string.editMilestone,
                            onPressed: () {
                              if (_keyFormAddEditMilestone.currentState
                                  !.validate())
                                bloc.createEditMilestone(
                                    textEditingController.text,
                                    textDescriptionController.text,
                                    widget.taskMileStoneModel == null);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
