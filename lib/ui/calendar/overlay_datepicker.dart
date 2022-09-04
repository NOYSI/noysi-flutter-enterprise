import 'package:code/_res/R.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/utils/extensions.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class OverlayDatePicker extends StatefulWidget {
  final ValueChanged<DateTime>? onDateSelected;
  final bool isMonthView;

  const OverlayDatePicker({this.onDateSelected, this.isMonthView = false});

  @override
  State<StatefulWidget> createState() => _OverlayDatePickerState();
}

class _OverlayDatePickerState
    extends StateWithBloC<OverlayDatePicker, OverlayDatePickerBloC> {
  @override
  void initState() {
    super.initState();
    bloc.expandDatePickerResult.listen((value) {
      if (value ?? false) {
        this._overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(this._overlayEntry!);
      } else {
        this._overlayEntry?.remove();
      }
    });
  }

  OverlayEntry? _overlayEntry;

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    var size = renderBox?.size;
    var offset = renderBox?.localToGlobal(Offset.zero);
    return OverlayEntry(
        builder: (BuildContext context) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: offset!.dy + size!.height),
                  color: Colors.white,
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Container(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 300,
                            child: SfDateRangePicker(
                              showNavigationArrow: true,
                              selectionColor: R.color.secondaryColor,
                              onViewChanged: (args) {
                                if (widget.isMonthView &&
                                    args.view == DateRangePickerView.month) {
                                  bloc.expandDatePicker();
                                  if (widget.onDateSelected != null)
                                    widget.onDateSelected!(
                                        args.visibleDateRange.startDate!);
                                }
                              },
                              headerStyle: DateRangePickerHeaderStyle(
                                backgroundColor: R.color.secondaryColor,
                                textAlign: TextAlign.center,
                                textStyle: TextStyle(
                                    color: R.color.whiteColor, fontSize: 16),
                              ),
                              todayHighlightColor: R.color.secondaryColor,
                              startRangeSelectionColor: R.color.secondaryColor,
                              endRangeSelectionColor: R.color.secondaryColor,
                              rangeSelectionColor: Colors.indigoAccent,
                              monthCellStyle: DateRangePickerMonthCellStyle(
                                todayTextStyle: TextStyle(
                                  color: R.color.secondaryColor,
                                ),
                              ),
                              yearCellStyle: DateRangePickerYearCellStyle(
                                todayTextStyle: TextStyle(
                                  color: R.color.secondaryColor,
                                ),
                              ),
                              view: widget.isMonthView
                                  ? DateRangePickerView.year
                                  : DateRangePickerView.month,
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              onSelectionChanged: (date) {
                                bloc.expandDatePicker();
                                if (widget.onDateSelected != null)
                                  widget.onDateSelected!(date.value);
                              },
                            ),
                          ),
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      bloc.expandDatePicker();
                                      if (widget.onDateSelected != null)
                                        widget.onDateSelected!(DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day,
                                            0,
                                            0,
                                            0));
                                    },
                                    child: TXTextWidget(
                                        color: R.color.darkColor,
                                        text: R.string.today.toUpperCase())),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                bloc.expandDatePicker();
              },
              onPanUpdate: (data) {
                bloc.expandDatePicker();
              },
            ));
  }

  @override
  Widget buildWidget(BuildContext context) {
    return TXIconButtonWidget(
      onPressed: () {
        //controller.displayDate = DateTime.now();
        bloc.expandDatePicker();
      },
      icon: Icon(
        Icons.today,
      ),
    );
  }
}

class OverlayDatePickerBloC extends BaseBloC {
  @override
  void dispose() {
    _expandDatePickerController.close();
  }

  BehaviorSubject<bool?> _expandDatePickerController = BehaviorSubject();

  Stream<bool?> get expandDatePickerResult =>
      _expandDatePickerController.stream;

  void expandDatePicker() {
    _expandDatePickerController
        .sinkAddSafe(!(_expandDatePickerController.valueOrNull ?? false));
  }

  bool get isExpanded => _expandDatePickerController.valueOrNull ?? false;
}
