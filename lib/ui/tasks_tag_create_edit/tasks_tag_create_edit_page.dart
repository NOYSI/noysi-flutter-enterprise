import 'package:code/_res/R.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/tasks_tag_create_edit/tasks_tag_create_edit_bloc.dart';
import 'package:code/ui/tasks_tag_selector/tag_colo_ui_model.dart';
import 'package:flutter/material.dart';

class TasksTagCreateEditPage extends StatefulWidget {
  final TaskLabelModel? taskLabelModel;
  final String previewName;
  final String channelId;

  const TasksTagCreateEditPage({Key? key, this.taskLabelModel, this.previewName = '', required this.channelId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TasksTagCreateEditState();
}

class _TasksTagCreateEditState
    extends StateWithBloC<TasksTagCreateEditPage, TaskTagCreateEditBloc> {
  TextEditingController textEditingController = TextEditingController();
  final _keyFormAdd = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textEditingController.text = (widget.taskLabelModel?.name ??  widget.previewName);
    bloc.initViewData(widget.taskLabelModel, widget.channelId);
    bloc.addEditLabelResult.listen((label) {
      NavigationUtils.pop(context, result: label);
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        TXMainAppBarWidget(
          title: widget.taskLabelModel != null
              ? R.string.editTag
              : R.string.createNewTag,
          body: Container(
            child: Form(
              key: _keyFormAdd,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: StreamBuilder<TaskLabelModel>(
                            stream: bloc.initResult,
                            initialData: null,
                            builder: (context, snapshot) {
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
                                    height: 10,
                                  ),
                                  TXTextWidget(
                                    text: R.string.color,
                                    color: R.color.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Container(
                                    child: StreamBuilder<List<TagColorUIModel>>(
                                      stream: bloc.labelColorResult,
                                      initialData: [],
                                      builder: (ctx, snapshotColors) {
                                        return Wrap(
                                          children: [
                                            ..._getColorsWidgets(snapshotColors.data!)
                                          ],
                                        );
                                      },
                                    ),
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
                            title: widget.taskLabelModel == null ? R.string.addTag : R.string.update,
                            onPressed: () {
                              if (_keyFormAdd.currentState!.validate())
                                bloc.createEditTag(textEditingController.text, widget.taskLabelModel == null);
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

  List<Widget> _getColorsWidgets(List<TagColorUIModel> list){
    List<Widget> resultList = [];
    list.forEach((label) {
      final w = InkWell(
          onTap: () {
            bloc.selectLabel(label.id);
          },
          child: Container(
            margin: EdgeInsets.all(5),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: label.color,
                borderRadius:
                BorderRadius.all(
                    Radius.circular(
                        4))),
            child: label.isSelected
                ? Icon(
              Icons
                  .check_circle_outline,
              color: R
                  .color.blackColor,
            )
                : Container(),
          ));
      resultList.add(w);
    });
    return resultList;
  }
}
