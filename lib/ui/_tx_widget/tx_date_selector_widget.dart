import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:flutter/material.dart';

class TXDateSelectorWidget extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime?>? onDateSelected;
  final String? title;
  final DateTime? firsDate;
  final bool isBlocked;
  final bool showTimePicker;
  final String? dateFormat;

  const TXDateSelectorWidget({
    Key? key,
    this.initialDate,
    this.firsDate,
    this.onDateSelected,
    this.title,
    this.isBlocked = false,
    this.showTimePicker = true,
    this.dateFormat,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TXDateSelectorState();
}

class _TXDateSelectorState extends State<TXDateSelectorWidget> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedDate = widget.initialDate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TXTextWidget(
          text: widget.title ?? R.string.deliveryDate,
          color: R.color.blackColor,
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      side: BorderSide(color: R.color.grayColor, width: .5),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(widget.isBlocked ? R.color.grayLightestColor : null),
                ),
                icon: Icon(
                  Icons.date_range,
                  size: 15,
                  color: R.color.blackColor,
                ),
                label: Container(
                  constraints: BoxConstraints(maxWidth: 230, minWidth: 180),
                  child: TXTextWidget(
                    text: selectedDate != null
                        ? CalendarUtils.showInFormat(
                                widget.dateFormat ?? R.string.dateFormat4,
                                selectedDate)!
                            .toLowerCase()
                        : "",
                    maxLines: 1,
                    color: R.color.blackColor,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
                onPressed: () {
                  _selectDate(context);
                },
              ),
              selectedDate == null
                  ? Container()
                  : !widget.isBlocked
                      ? TXIconButtonWidget(
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedDate = null;
                            });
                            if (widget.onDateSelected != null)
                              widget.onDateSelected!(null);
                          },
                        )
                      : Container()
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime pickerDate = selectedDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: widget.firsDate ?? DateTime(1970, 1, 1),
        lastDate: pickerDate.add(Duration(days: 365)));
    if (picked != null) {
      pickerDate = picked;
      setState(() {
        selectedDate = pickerDate;
        if (widget.onDateSelected != null) widget.onDateSelected!(selectedDate);
      });
      if (widget.showTimePicker) {
        final timeOfDay = await showTimePicker(
            context: context,
            initialTime:
                TimeOfDay(hour: pickerDate.hour, minute: pickerDate.minute));
        if (timeOfDay != null) {
          final newDueDate = DateTime(pickerDate.year, pickerDate.month,
              pickerDate.day, timeOfDay.hour, timeOfDay.minute);
          setState(() {
            selectedDate = newDueDate;
            if (widget.onDateSelected != null)
              widget.onDateSelected!(selectedDate);
          });
        }
      }
    }
  }
}
