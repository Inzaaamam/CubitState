import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class ReactiveTimePickerSpinnerPopUp
    extends ReactiveFormField<DateTime, DateTime> {
  ReactiveTimePickerSpinnerPopUp({
    super.key,
    required String super.formControlName,
    DateTime? initTime,
    DateTime? minTime,
    DateTime? maxTime,
    String cancelText = 'Cancel',
    String confirmText = 'OK',
    String timeFormat = 'dd/MM/yyyy HH:mm',
    int minuteInterval = 1,
    EdgeInsets padding = const EdgeInsets.fromLTRB(12, 10, 12, 10),
    PressType pressType = PressType.singlePress,
    Color barrierColor = Colors.black12,
    double radius = 10,
    Locale? locale,
  }) : super(
          builder: (ReactiveFormFieldState<DateTime, DateTime> field) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: field.context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: TimePickerSpinnerPopUp(
                        mode: CupertinoDatePickerMode.date,
                        // initTime: field.value ?? initTime ?? DateTime.now(),
                        // minTime: minTime ??
                        //     DateTime.now().subtract(const Duration(days: 10)),
                        // maxTime: maxTime ??
                        //     DateTime.now().add(const Duration(days: 10)),
                        barrierColor: barrierColor,
                        cancelText: cancelText,
                        confirmText: confirmText,
                        pressType: pressType,
                        radius: radius,
                        timeFormat: timeFormat,
                        locale: locale ?? const Locale('en'),
                        onChange: (selectedDateTime) {
                          field.didChange(selectedDateTime);
                        },
                      ),
                    );
                  },
                );
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Select Date and Time',
                  errorText: field.errorText,
                ),
                child: Text(
                  field.value != null
                      ? '${field.value!.day}/${field.value!.month}/${field.value!.year} '
                      : 'No date and time selected',
                ),
              ),
            );
          },
        );
}
