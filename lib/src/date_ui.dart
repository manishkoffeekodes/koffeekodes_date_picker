import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomCalendarUI extends StatefulWidget {
  /// The initial date to be displayed when the calendar is opened.
  /// use this to set the [initialDate] initial date
  ///  use this format DateTime(2021, 3, 24),
  final DateTime initialDate;

  /// The first date that can be selected in the calendar.
  /// use this to set the [firstDate] initial date
  /// use this format DateTime(2021),
  final DateTime firstDate;

  /// The last date that can be selected in the calendar.
  /// use this to set the [lastDate] initial date
  /// use this format DateTime(2025),
  final DateTime lastDate;

  /// A boolean value to show or hide the buttons.
  /// use this to set the [isButtonShow] initial button.
  /// use this to set the true or false,
  final bool? isButtonShow;

  /// The width of the border around the calendar.
  /// use this to set the [borderWidth] initial border width.
  /// use this to set the 1.0,
  final double? borderWidth;

  /// The color of the border around the calendar.
  /// use this to set the [borderColor] initial border color.
  /// use this to set the Colors.grey,
  final Color? borderColor;

  /// The color of the selected date.
  /// use this to set the [selectedColor] initial selected color.
  /// use this to set the Colors.blue,
  final Color? selectedColor;

  /// The color of the unselected date.
  /// use this to set the [unSelectedColor] initial unselected color.
  /// use this to set the Colors.transparent,
  final Color? unSelectedColor;

  /// The color of the text for the selected date.
  /// use this to set the [textColor] initial text color.
  /// use this to set the Colors.black,
  final Color? textColor;

  /// The color of the text for the selected date.
  /// use this to set the [textSelectedColor] initial text selected color.
  /// use this to set the Colors.white,
  final Color? textSelectedColor;

  /// The color of the text for the disabled date.
  /// use this to set the [textDisabledColor] initial text disabled color.
  /// use this to set the Colors.grey[500],
  final Color? disabledColor;

  /// The color of the text for the disabled date.
  /// use this to set the [textDisabledColor] initial text disabled color.
  /// use this to set the Colors.grey[500],
  final Color? textDisabledColor;

  /// The color of the arrow.
  /// use this to set the [arrowColor] initial arrow color.
  /// use this to set the Colors.grey,
  final Color? arrowColor;

  /// The decoration for the calendar box.
  /// use this to set the [boxDecoration] initial box decoration.
  /// use this to set the
  /// BoxDecoration(
  /// color: Colors.grey[100],
  /// borderRadius: BorderRadius.circular(16),
  /// boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
  /// ),
  final Decoration? boxDecoration;

  /// The text style for the header.
  ///  use this to set the [headerTextStyle] initial header text style.
  ///  use this to set the TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  final TextStyle? headerTextStyle;

  /// The text style for the day.
  /// use this to set the [dayTextStyle] initial day text style.
  /// use this to set the TextStyle(fontSize: 16),
  final TextStyle? dayTextStyle;

  /// The color of the focus.
  /// use this to set the [focusColor] initial focus color.
  /// use this to set the Colors.grey.shade300,
  final Color? focusColor;

  /// The border radius of the calendar.
  /// use this to set the [borderRadius] initial border radius.
  /// use this to set the BorderRadius.circular(8),
  final BorderRadiusGeometry? borderRadius;

  /// The function to be called when a date is selected.
  /// use this to set the [onDateSelected] initial date selected.
  /// use this to set the Function(DateTime value),
  final Function(DateTime value) onDateSelected;
  // 2 button Decoration
  /// The child widget for the cancel button.
  /// use this to set the [cancelButton] initial cancel button child.
  /// use this to set the
  /// Container(
  ///  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  ///  decoration: BoxDecoration(
  /// borderRadius: BorderRadius.circular(20),
  /// ),
  ///  child: const Text(
  ///  "Cancel",
  ///   style: TextStyle(color: Colors.black),
  ///  ),
  /// )
  final Widget? cancelButton;

  /// The child widget for the done button.
  /// use this to set the [doneButton] initial done button child.
  /// use this to set the
  /// Container(
  /// padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  /// decoration: BoxDecoration(
  /// borderRadius: BorderRadius.circular(20),
  /// ),
  /// child: const Text(
  /// "Done",
  /// style: TextStyle(color: Colors.black),
  /// ),
  /// )
  final Widget? doneButton;

  /// The function to be called when the cancel button is pressed.
  /// use this to set the [onCancel] initial cancel button function.
  /// use this to set the (){},
  final Function()? onCancel;

  /// The function to be called when the done button is pressed.
  /// use this to set the [onDone] initial done button function.
  /// use this to set the (){},
  final Function()? onDone;

  /// The main axis alignment for the buttons.
  /// use this to set the [buttonMainAxisAlignment] initial button main axis alignment.
  /// use this to set the MainAxisAlignment.end,
  final MainAxisAlignment? buttonMainAxisAlignment;

  /// The cross axis alignment for the buttons.
  /// use this to set the [buttonCrossAxisAlignment] initial button cross axis alignment.
  /// use this to set the CrossAxisAlignment.center,
  final CrossAxisAlignment? buttonCrossAxisAlignment;

  CustomCalendarUI({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
    required this.firstDate,
    required this.lastDate,
    this.isButtonShow,
    this.borderWidth,
    this.borderColor,
    this.selectedColor,
    this.unSelectedColor,
    this.textColor,
    this.textSelectedColor,
    this.disabledColor,
    this.textDisabledColor,
    this.boxDecoration,
    this.arrowColor,
    this.headerTextStyle,
    this.dayTextStyle,
    this.focusColor,
    this.borderRadius,
    // 2 button Decoration
    this.cancelButton,
    this.doneButton,
    this.onCancel,
    this.onDone,
    this.buttonMainAxisAlignment,
    this.buttonCrossAxisAlignment,
  }) {
    assert(
      !lastDate.isBefore(firstDate),
      'lastDate $lastDate must be on or after firstDate $firstDate.',
    );
    assert(
      !initialDate.isBefore(firstDate),
      'initialDate $initialDate must be on or after firstDate $firstDate.',
    );
    assert(
      !initialDate.isAfter(lastDate),
      'initialDate $initialDate must be on or before lastDate $lastDate.',
    );
  }

  @override
  State<CustomCalendarUI> createState() => _CustomCalendarUIState();
}

class _CustomCalendarUIState extends State<CustomCalendarUI> {
  // Variables to manage the state of the calendar

  // The currently selected date
  late DateTime selectedDate;
  // The date currently focused (for keyboard navigation)
  late DateTime focusSelectedDate;
  // The focused month
  late DateTime focusSelectedMont;
  // The month currently displayed in the calendar
  late DateTime displayedMonth;
  // The currently selected year
  late int selectedYear;
  // The start year of the current decade
  late int currentDecadeStart;
  // Whether the month/year picker is open
  bool isMonthYearPickerOpen = false;
  // Whether the decade picker is open
  bool isDecadePickerOpen = false;
  // Temporary year for navigation
  late int tempYear;
  // Another reference to the selected date
  late DateTime selectedDate1;
  // The index of the currently focused month
  late int focusedMonthIndex;
  // Flag to track temporary year changes
  bool isTempYear = false;

  @override
  void initState() {
    super.initState();

    // Initialize variables with the initial date provided by the widget

    selectedDate = widget.initialDate;
    focusSelectedDate = widget.initialDate;
    selectedDate1 = widget.initialDate;
    focusedMonthIndex = widget.initialDate.month - 1;
    focusSelectedMont = DateTime(
      widget.initialDate.year,
      widget.initialDate.month,
    );
    displayedMonth = DateTime(
      widget.initialDate.year,
      widget.initialDate.month,
      1,
    );
    selectedYear = widget.initialDate.year;
    tempYear = displayedMonth.year;

    // Calculate the start of the current decade

    currentDecadeStart = (selectedYear ~/ 10) * 10;
  }

  // Navigate to the previous month

  void goToPreviousMonth() {
    if (displayedMonth.isAfter(DateTime(widget.firstDate.year, 1))) {
      setState(() {
        // Update the displayed month to the previous month

        displayedMonth = DateTime(
          displayedMonth.year,
          displayedMonth.month - 1,
        );
      });
    }
  }

  // Navigate to the next month

  void goToNextMonth() {
    if (displayedMonth.isBefore(DateTime(widget.lastDate.year, 12))) {
      setState(() {
        // Update the displayed month to the next month

        displayedMonth = DateTime(
          displayedMonth.year,
          displayedMonth.month + 1,
        );
      });
    }
  }

  // Generate a list of 42 days to display in the calendar grid

  List<DateTime> _generateCalendarDays() {
    // Get the first day of the currently displayed month
    final firstDayOfMonth = DateTime(
      displayedMonth.year,
      displayedMonth.month,
      1,
      0,
      0,
      0,
    ); // Set time to midnight
    int daysBefore =
        firstDayOfMonth.weekday %
        7; // Calculate the number of days to show from the previous month

    // Generate 42 days (6 weeks) for the calendar grid
    return List.generate(42, (index) {
      final date = firstDayOfMonth
          .subtract(Duration(days: daysBefore))
          .add(Duration(days: index));
      return DateTime(
        date.year,
        date.month,
        date.day,
        date.hour,
        0,
        0,
      ); // Ensure time is set to midnight
    });
  }

  FocusNode cancelFocusNode = FocusNode(); // Focus node for the cancel button
  FocusNode doneFocusNode = FocusNode(); // Focus node for the done button

  Widget buildHeaderCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      // height: (widget.isButtonShow ?? true) ? 460 : 410,
      width: 350,
      decoration:
          widget.boxDecoration ??
          BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
          ),
      child: Column(
        children: [
          child,

          SizedBox(height: (widget.isButtonShow ?? true) ? 10 : 0),

          (widget.isButtonShow ?? true)
              ? Row(
                mainAxisAlignment:
                    widget.buttonMainAxisAlignment ?? MainAxisAlignment.end,
                crossAxisAlignment:
                    widget.buttonCrossAxisAlignment ??
                    CrossAxisAlignment.center,
                children: [
                  InkWell(
                    focusNode: cancelFocusNode,
                    focusColor: widget.focusColor ?? Colors.grey.shade300,
                    onTap: () {
                      Navigator.pop(context);
                      widget.onCancel;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:
                            (cancelFocusNode.hasFocus == true)
                                ? widget.focusColor ?? Colors.grey.shade300
                                : Colors.transparent,
                      ),
                      child:
                          widget.cancelButton ??
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                    ),
                  ),

                  const SizedBox(width: 10),
                  InkWell(
                    focusNode: doneFocusNode,
                    focusColor: widget.focusColor ?? Colors.grey.shade300,
                    onTap: () {
                      setState(() {
                        widget.onDateSelected(focusSelectedDate);
                        Navigator.pop(context);
                      });
                      widget.onDone;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:
                            (doneFocusNode.hasFocus == true)
                                ? widget.focusColor ?? Colors.grey.shade300
                                : Colors.transparent,
                        // borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          widget.doneButton ??
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Done",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                    ),
                  ),
                ],
              )
              : Container(),
        ],
      ),
    );
  }

  // ----------------------------------------------- Years ---------------------------------------------------->
  FocusNode arrowLeftYearFocusNode =
      FocusNode(); // Focus node for the left arrow button
  FocusNode arrowRightYearFocusNode =
      FocusNode(); // Focus node for the right arrow button
  FocusNode yearGridFocusNode = FocusNode(); // Focus node for the year grid

  /// Builds the year picker widget, allowing users to select a year from a grid.
  Widget buildYearPicker() {
    // Generate a grid of 16 years starting from the current decade start
    final List<int?> yearsGrid = List.generate(
      16,
      (index) => currentDecadeStart + index,
    );

    return CallbackShortcuts(
      bindings: {
        // Handles the Enter key for various focus nodes
        LogicalKeySet(LogicalKeyboardKey.enter): () {
          if (arrowLeftYearFocusNode.hasFocus) {
            // Navigate to the previous decade if the first year is not reached
            var isYearsList =
                yearsGrid
                    .where((element) => element == widget.firstDate.year)
                    .toList();
            if ((isYearsList.firstOrNull == null) ||
                isYearsList.first != widget.firstDate.year) {
              setState(() {
                currentDecadeStart -= 16;
                tempYear =
                    currentDecadeStart; // Update tempYear to the first year of the new decade
              });
            }
          }
          if (arrowRightYearFocusNode.hasFocus) {
            // Navigate to the next decade if the last year is not reached
            var isYearsList =
                yearsGrid
                    .where((element) => element == widget.lastDate.year)
                    .toList();
            if ((isYearsList.firstOrNull == null) ||
                isYearsList.first != widget.lastDate.year) {
              setState(() {
                currentDecadeStart += 16;
                tempYear =
                    currentDecadeStart; // Update tempYear to the first year of the new decade
              });
            }
          }
          if (yearGridFocusNode.hasFocus) {
            // Select the currently focused year and open the month picker
            setState(() {
              selectedYear = tempYear;
              isMonthYearPickerOpen = true;
              isDecadePickerOpen = false;
            });
          }
          if (cancelFocusNode.hasFocus) {
            // Close the picker on cancel
            Navigator.pop(context);
          }
          if (doneFocusNode.hasFocus) {
            // Confirm the selected year and close the picker
            widget.onDateSelected(
              DateTime(tempYear, displayedMonth.month, focusSelectedDate.day),
            );
            Navigator.pop(context);
          }
        },
        // Handles left arrow key navigation
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): () {
          if (yearGridFocusNode.hasFocus) {
            if (tempYear > widget.firstDate.year) {
              setState(() {
                int currentIndex = yearsGrid.indexOf(tempYear);
                if (currentIndex > 0) {
                  tempYear = yearsGrid[currentIndex - 1]!;
                } else {
                  currentDecadeStart -= 16;
                  tempYear =
                      currentDecadeStart; // Update tempYear to the first year of the new decade
                }
              });
            }
          }
        },
        // Handles right arrow key navigation
        LogicalKeySet(LogicalKeyboardKey.arrowRight): () {
          if (yearGridFocusNode.hasFocus) {
            if (tempYear < widget.lastDate.year) {
              setState(() {
                int currentIndex = yearsGrid.indexOf(tempYear);
                if (currentIndex < yearsGrid.length - 1) {
                  tempYear = yearsGrid[currentIndex + 1]!;
                } else {
                  currentDecadeStart += 16;
                  tempYear =
                      currentDecadeStart; // Update tempYear to the first year of the new decade
                }
              });
            }
          }
        },
        // Handles up arrow key navigation
        LogicalKeySet(LogicalKeyboardKey.arrowUp): () {
          if (yearGridFocusNode.hasFocus) {
            int currentIndex = yearsGrid.indexOf(tempYear);
            int targetIndex = currentIndex - 4; // Move up by 4 rows
            if (targetIndex >= 0) {
              int targetYear = yearsGrid[targetIndex]!;
              if (targetYear >= widget.firstDate.year) {
                setState(() {
                  tempYear = targetYear;
                });
              }
            }
          }
        },
        // Handles down arrow key navigation
        LogicalKeySet(LogicalKeyboardKey.arrowDown): () {
          if (yearGridFocusNode.hasFocus) {
            int currentIndex = yearsGrid.indexOf(tempYear);
            int targetIndex = currentIndex + 4; // Move down by 4 rows
            if (targetIndex < yearsGrid.length) {
              int targetYear = yearsGrid[targetIndex]!;
              if (targetYear <= widget.lastDate.year) {
                setState(() {
                  tempYear = targetYear;
                });
              }
            } else {
              // Move to the next decade if possible
              int nextDecadeStart = currentDecadeStart + 16;
              if (nextDecadeStart <= widget.lastDate.year) {
                setState(() {
                  currentDecadeStart = nextDecadeStart;
                  tempYear = currentDecadeStart;
                });
              }
            }
          }
        },
        // Handles Tab key navigation between focus nodes
        LogicalKeySet(LogicalKeyboardKey.tab): () {
          if (arrowLeftYearFocusNode.hasFocus) {
            arrowRightYearFocusNode.requestFocus();
            setState(() {});
          } else if (arrowRightYearFocusNode.hasFocus) {
            yearGridFocusNode.requestFocus();
            setState(() {});
          } else if (yearGridFocusNode.hasFocus) {
            if (widget.isButtonShow ?? true) {
              cancelFocusNode.requestFocus();
            } else {
              arrowLeftYearFocusNode.requestFocus();
            }
            setState(() {});
          } else if (cancelFocusNode.hasFocus) {
            cancelFocusNode.unfocus();
            doneFocusNode.requestFocus();
            setState(() {});
          } else if (doneFocusNode.hasFocus) {
            doneFocusNode.unfocus();
            arrowLeftYearFocusNode.requestFocus();
            setState(() {});
          } else {
            arrowLeftYearFocusNode.requestFocus();
            setState(() {});
          }
        },
      },
      child: buildHeaderCard(
        child: Column(
          children: [
            // Header row with navigation arrows and decade range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  focusNode: arrowLeftYearFocusNode,
                  focusColor: widget.focusColor ?? Colors.grey.shade300,
                  icon: Icon(
                    Icons.arrow_left,
                    color: widget.arrowColor ?? Colors.grey,
                  ),
                  onPressed: () {
                    var isYearsList =
                        yearsGrid
                            .where(
                              (element) => element == widget.firstDate.year,
                            )
                            .toList();
                    if ((isYearsList.firstOrNull == null) ||
                        isYearsList.first != widget.firstDate.year) {
                      setState(() => currentDecadeStart -= 16);
                    }
                  },
                ),
                Text(
                  "$currentDecadeStart - ${currentDecadeStart + 15}",
                  style:
                      widget.headerTextStyle ??
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  focusNode: arrowRightYearFocusNode,
                  focusColor: widget.focusColor ?? Colors.grey.shade300,
                  icon: Icon(
                    Icons.arrow_right,
                    color: widget.arrowColor ?? Colors.grey,
                  ),
                  onPressed: () {
                    var isYearsList =
                        yearsGrid
                            .where((element) => element == widget.lastDate.year)
                            .toList();
                    if ((isYearsList.firstOrNull == null) ||
                        isYearsList.first != widget.lastDate.year) {
                      setState(() => currentDecadeStart += 16);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Year grid for selection
            Focus(
              focusNode: yearGridFocusNode,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 16,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final year = yearsGrid[index]!;
                  final isDisabled =
                      year < widget.firstDate.year ||
                      year > widget.lastDate.year;
                  final isSelected = year == selectedYear && !isDisabled;

                  return GestureDetector(
                    onTap:
                        isDisabled
                            ? null
                            : () {
                              setState(() {
                                selectedYear = year;
                                tempYear = year;
                                isDecadePickerOpen = false;
                              });
                            },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isDisabled
                                ? widget.disabledColor ?? Colors.grey.shade300
                                : isSelected
                                ? widget.selectedColor ?? Colors.blue
                                : widget.unSelectedColor ?? Colors.transparent,
                        borderRadius:
                            widget.borderRadius ?? BorderRadius.circular(8),
                        border:
                            (yearGridFocusNode.hasFocus && tempYear == year)
                                ? Border.all(
                                  color: widget.borderColor ?? Colors.grey,
                                  width: widget.borderWidth ?? 1.0,
                                )
                                : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$year',
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              isDisabled
                                  ? widget.textDisabledColor ?? Colors.grey[500]
                                  : isSelected
                                  ? widget.textSelectedColor ?? Colors.white
                                  : widget.textColor ?? Colors.black,
                          fontWeight:
                              isDisabled ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------- Months ---------------------------------------------------->
  FocusNode arrowLeftMonthFocusNode =
      FocusNode(); // Focus node for the left arrow button
  FocusNode yearFocusNode = FocusNode(); // Focus node for the year text
  FocusNode arrowRightMonthFocusNode =
      FocusNode(); // Focus node for the right arrow button
  FocusNode monthFocusNode = FocusNode(); // Focus node for the month grid

  /// Builds the month picker widget, allowing users to select a month.
  Widget buildMonthPicker() {
    // Generate a list of months for the current year
    final months = List.generate(12, (index) => DateTime(tempYear, index + 1));

    return CallbackShortcuts(
      bindings: {
        // Handles the Enter key for various focus nodes
        LogicalKeySet(LogicalKeyboardKey.enter): () {
          if (yearFocusNode.hasFocus) {
            // Open the decade picker when the year text is focused
            setState(() {
              isDecadePickerOpen = true;
            });
          }
          if (monthFocusNode.hasFocus) {
            // Select the currently focused month
            setState(() {
              selectedDate1 = DateTime(tempYear, focusedMonthIndex + 1);
              displayedMonth = DateTime(
                tempYear,
                months[focusedMonthIndex].month,
              );
              selectedYear = tempYear;
              isMonthYearPickerOpen = false;
              isDecadePickerOpen = false;
            });
          }
          if (cancelFocusNode.hasFocus) {
            // Close the picker on cancel
            Navigator.pop(context);
          }
          if (doneFocusNode.hasFocus) {
            // Confirm the selected month and close the picker
            widget.onDateSelected(selectedDate1);
            Navigator.pop(context);
          }
          if (arrowRightMonthFocusNode.hasFocus) {
            // Navigate to the next year
            if (tempYear < widget.lastDate.year) {
              setState(() => tempYear++);
            }
          }
          if (arrowLeftMonthFocusNode.hasFocus) {
            // Navigate to the previous year
            if (tempYear > widget.firstDate.year) {
              setState(() => tempYear--);
            }
          }
        },
        // Handles up arrow key navigation
        LogicalKeySet(LogicalKeyboardKey.arrowUp): () {
          if (monthFocusNode.hasFocus) {
            if (focusedMonthIndex >= 4) {
              focusedMonthIndex -= 4; // Move up by 4 rows
            }
            setState(() {});
          }
        },
        // Handles down arrow key navigation
        LogicalKeySet(LogicalKeyboardKey.arrowDown): () {
          if (monthFocusNode.hasFocus) {
            if (focusedMonthIndex <= 7) {
              focusedMonthIndex += 4; // Move down by 4 rows
            }
            setState(() {});
          }
        },
        // Handles left arrow key navigation
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): () {
          if (monthFocusNode.hasFocus) {
            if (focusedMonthIndex > 0) {
              focusedMonthIndex--; // Move to the previous month
            } else {
              if (tempYear > widget.firstDate.year) {
                focusedMonthIndex =
                    11; // Wrap to the last month of the previous year
                tempYear--;
              }
            }
            setState(() {});
          }
        },
        // Handles right arrow key navigation
        LogicalKeySet(LogicalKeyboardKey.arrowRight): () {
          if (monthFocusNode.hasFocus) {
            if (focusedMonthIndex < 11) {
              focusedMonthIndex++; // Move to the next month
            } else {
              if (tempYear < widget.lastDate.year) {
                focusedMonthIndex =
                    0; // Wrap to the first month of the next year
                tempYear++;
              }
            }
            setState(() {});
          }
        },
        // Handles Tab key navigation between focus nodes
        LogicalKeySet(LogicalKeyboardKey.tab): () {
          if (arrowLeftMonthFocusNode.hasFocus) {
            yearFocusNode.requestFocus();
            setState(() {});
          } else if (yearFocusNode.hasFocus) {
            yearFocusNode.unfocus();
            arrowRightMonthFocusNode.requestFocus();
            setState(() {});
          } else if (arrowRightMonthFocusNode.hasFocus) {
            monthFocusNode.requestFocus();
            setState(() {});
          } else if (monthFocusNode.hasFocus) {
            monthFocusNode.unfocus();
            if (widget.isButtonShow ?? true) {
              cancelFocusNode.requestFocus();
            } else {
              arrowLeftMonthFocusNode.requestFocus();
            }
            setState(() {});
          } else if (cancelFocusNode.hasFocus) {
            cancelFocusNode.unfocus();
            doneFocusNode.requestFocus();
            setState(() {});
          } else if (doneFocusNode.hasFocus) {
            doneFocusNode.unfocus();
            arrowLeftMonthFocusNode.requestFocus();
            setState(() {});
          } else {
            arrowLeftMonthFocusNode.requestFocus();
            setState(() {});
          }
        },
      },
      child: buildHeaderCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header row with navigation arrows and year text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  focusNode: arrowLeftMonthFocusNode,
                  focusColor: widget.focusColor ?? Colors.grey.shade300,
                  onPressed: () {
                    if (tempYear > widget.firstDate.year) {
                      setState(() => tempYear--);
                    }
                  },
                  icon: Icon(
                    Icons.arrow_left,
                    color: widget.arrowColor ?? Colors.grey,
                  ),
                ),
                Focus(
                  focusNode: yearFocusNode,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color:
                          (yearFocusNode.hasFocus == true)
                              ? widget.focusColor ?? Colors.grey.shade300
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isDecadePickerOpen = true; // Open the decade picker
                        });
                      },
                      child: Text(
                        "$tempYear",
                        style:
                            widget.headerTextStyle ??
                            TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  focusNode: arrowRightMonthFocusNode,
                  focusColor: widget.focusColor ?? Colors.grey.shade300,
                  onPressed: () {
                    if (tempYear < widget.lastDate.year) {
                      setState(() => tempYear++);
                    }
                  },
                  icon: Icon(
                    Icons.arrow_right,
                    color: widget.arrowColor ?? Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Month grid for selection
            GridView.builder(
              shrinkWrap: true,
              itemCount: months.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 14,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final isSelected =
                    selectedDate1.year == months[index].year &&
                    selectedDate1.month == months[index].month;
                final isFocused = focusedMonthIndex == index;
                return Focus(
                  focusNode: monthFocusNode,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        displayedMonth = DateTime(
                          tempYear,
                          months[index].month,
                        );
                        selectedDate1 = months[index];
                        focusedMonthIndex = index;
                        selectedYear = tempYear;
                        isMonthYearPickerOpen = false;
                        isDecadePickerOpen = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? widget.selectedColor ?? Colors.blue
                                : widget.unSelectedColor ?? Colors.transparent,
                        border:
                            (monthFocusNode.hasFocus == true) && (isFocused)
                                ? Border.all(
                                  color: widget.borderColor ?? Colors.grey,
                                  width: widget.borderWidth ?? 1.0,
                                )
                                : null,
                        borderRadius:
                            widget.borderRadius ?? BorderRadius.circular(8),
                      ),
                      child: Text(
                        DateFormat.MMM().format(months[index]),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:
                              isSelected
                                  ? widget.textSelectedColor ?? Colors.white
                                  : widget.textColor ?? Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Moves focus to an adjacent month in the calendar grid.
  void moveFocusToAdjacentMonth(int direction, int currentIndex) {
    setState(() {
      displayedMonth = DateTime(
        displayedMonth.year,
        displayedMonth.month + direction,
      );
      final newMonthDays = _generateCalendarDays();
      int weekdayColumn = currentIndex % 7;

      final monthDates =
          newMonthDays
              .where((date) => date.month == displayedMonth.month)
              .toList();

      DateTime selectedDate =
          direction < 0
              ? monthDates.lastWhere(
                (date) => date.weekday % 7 == weekdayColumn,
                orElse: () => monthDates.last,
              )
              : monthDates.firstWhere(
                (date) => date.weekday % 7 == weekdayColumn,
                orElse: () => monthDates.first,
              );

      focusSelectedDate = selectedDate;
    });
  }

  // ----------------------------------------------- Ddy ---------------------------------------------------->
  // Focus nodes for managing keyboard focus on different UI elements
  FocusNode arrowLeftFocusNode = FocusNode(); // Focus for the left arrow button
  FocusNode arrowRightFocusNode =
      FocusNode(); // Focus for the right arrow button
  FocusNode monthYearFocusNode = FocusNode(); // Focus for the month/year text
  FocusNode dateFocusNode = FocusNode(); // Focus for individual date cells

  /// Builds the date picker widget with keyboard navigation and focus management.
  Widget buildDatePicker() {
    // Generate the list of calendar days for the current month view
    final calendarDays = _generateCalendarDays();

    // Ensure the focused date is within the displayed month
    focusSelectedDate = DateTime(
      displayedMonth.year,
      displayedMonth.month,
      focusSelectedDate.day,
    );

    // Format the current month and year for display
    final String currentMonthTitle = DateFormat(
      'MMMM,yyyy',
    ).format(displayedMonth);

    // Find the index of the currently focused date in the calendar days list
    final currentIndex = calendarDays.indexOf(
      DateFormat(
        'yyyy-MM-dd',
      ).parse(DateFormat('yyyy-MM-dd').format(focusSelectedDate)),
    );

    return CallbackShortcuts(
      bindings: {
        // Handle the Enter key for various focus nodes
        LogicalKeySet(LogicalKeyboardKey.enter): () {
          if (arrowLeftFocusNode.hasFocus) {
            // Navigate to the previous month
            if (displayedMonth.isAfter(DateTime(widget.firstDate.year, 1))) {
              setState(() => goToPreviousMonth());
            }
          } else if (monthYearFocusNode.hasFocus) {
            // Open the month/year picker
            setState(() {
              isMonthYearPickerOpen = true;
            });
          } else if (arrowRightFocusNode.hasFocus) {
            // Navigate to the next month
            if (displayedMonth.isBefore(DateTime(widget.lastDate.year, 12))) {
              setState(() => goToNextMonth());
            }
          } else if (dateFocusNode.hasFocus) {
            // Select the currently focused date
            widget.onDateSelected(focusSelectedDate);
            Navigator.pop(context);
          } else if (cancelFocusNode.hasFocus) {
            // Close the picker on cancel
            Navigator.pop(context);
          } else if (doneFocusNode.hasFocus) {
            // Confirm the selected date and close the picker
            widget.onDateSelected(focusSelectedDate);
            Navigator.pop(context);
          }
        },
        // Handle the Tab key for navigating between focus nodes
        LogicalKeySet(LogicalKeyboardKey.tab): () {
          if (arrowLeftFocusNode.hasFocus) {
            monthYearFocusNode.requestFocus();
            setState(() {});
          } else if (monthYearFocusNode.hasFocus) {
            monthYearFocusNode.unfocus();
            arrowRightFocusNode.requestFocus();
            setState(() {});
          } else if (arrowRightFocusNode.hasFocus) {
            dateFocusNode.requestFocus();
            setState(() {});
          } else if (dateFocusNode.hasFocus) {
            dateFocusNode.unfocus();
            if (widget.isButtonShow ?? true) {
              cancelFocusNode.requestFocus();
            } else {
              arrowLeftFocusNode.requestFocus();
            }
            setState(() {});
          } else if (cancelFocusNode.hasFocus) {
            cancelFocusNode.unfocus();
            doneFocusNode.requestFocus();
            setState(() {});
          } else if (doneFocusNode.hasFocus) {
            doneFocusNode.unfocus();
            arrowLeftFocusNode.requestFocus();
            setState(() {});
          } else {
            arrowLeftFocusNode.requestFocus();
          }
        },
        // Handle the Left Arrow key for navigating to the previous date
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): () {
          if (dateFocusNode.hasFocus) {
            if (currentIndex > 0) {
              final prevDate = calendarDays[currentIndex - 1];
              if (!prevDate.isBefore(widget.firstDate)) {
                setState(() {
                  focusSelectedDate = prevDate;
                  if (focusSelectedDate.month != displayedMonth.month) {
                    displayedMonth = DateTime(
                      focusSelectedDate.year,
                      focusSelectedDate.month,
                    );
                  }
                });
              }
            }
          }
        },
        // Handle the Right Arrow key for navigating to the next date
        LogicalKeySet(LogicalKeyboardKey.arrowRight): () {
          if (dateFocusNode.hasFocus) {
            var isCurrentIndexDays = currentIndex < calendarDays.length - 1;
            if (isCurrentIndexDays) {
              final lastAllowedDate = DateTime(widget.lastDate.year, 12, 31);
              final nextDate = calendarDays[currentIndex + 1];
              if (!nextDate.isAfter(lastAllowedDate)) {
                setState(() {
                  focusSelectedDate = nextDate;
                  if (focusSelectedDate.month != displayedMonth.month) {
                    displayedMonth = DateTime(
                      focusSelectedDate.year,
                      focusSelectedDate.month,
                    );
                  }
                });
              }
            }
          }
        },
        // Handle the Up Arrow key for navigating to the date above
        LogicalKeySet(LogicalKeyboardKey.arrowUp): () {
          if (dateFocusNode.hasFocus) {
            int targetIndex = currentIndex - 7;
            if (targetIndex >= 0 &&
                calendarDays[targetIndex].month == displayedMonth.month) {
              final targetDate = calendarDays[targetIndex];
              if (!targetDate.isBefore(widget.firstDate)) {
                setState(() => focusSelectedDate = targetDate);
              }
            } else {
              // Move to the previous month if necessary
              final prevMonth = DateTime(
                displayedMonth.year,
                displayedMonth.month - 1,
                1,
              );
              if (!prevMonth.isBefore(
                DateTime(widget.firstDate.year, widget.firstDate.month, 1),
              )) {
                moveFocusToAdjacentMonth(-1, currentIndex);
              }
            }
          }
        },
        // Handle the Down Arrow key for navigating to the date below
        LogicalKeySet(LogicalKeyboardKey.arrowDown): () {
          if (dateFocusNode.hasFocus) {
            int targetIndex = currentIndex + 7;
            if (targetIndex < calendarDays.length &&
                calendarDays[targetIndex].month == displayedMonth.month) {
              final targetDate = calendarDays[targetIndex];
              final lastAllowedDate = DateTime(widget.lastDate.year, 12, 31);
              if (!targetDate.isAfter(lastAllowedDate)) {
                setState(() => focusSelectedDate = targetDate);
              }
            } else {
              // Move to the next month if necessary
              final nextMonth = DateTime(
                displayedMonth.year,
                displayedMonth.month + 1,
                1,
              );
              final lastAllowedDate = DateTime(widget.lastDate.year, 12, 31);
              if (!nextMonth.isAfter(lastAllowedDate)) {
                moveFocusToAdjacentMonth(1, currentIndex);
              }
            }
          }
        },
      },
      child: buildHeaderCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header row with navigation arrows and month/year text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  focusNode: arrowLeftFocusNode,
                  focusColor: widget.focusColor ?? Colors.grey.shade300,
                  onPressed: goToPreviousMonth,
                  icon: Icon(
                    Icons.arrow_left,
                    color: widget.arrowColor ?? Colors.grey,
                  ),
                ),
                Focus(
                  focusNode: monthYearFocusNode,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color:
                          (monthYearFocusNode.hasFocus == true)
                              ? widget.focusColor ?? Colors.grey.shade300
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () => setState(() => isMonthYearPickerOpen = true),
                      child: Text(
                        currentMonthTitle,
                        style:
                            widget.headerTextStyle ??
                            TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  focusNode: arrowRightFocusNode,
                  onPressed: goToNextMonth,
                  focusColor: widget.focusColor ?? Colors.grey.shade300,
                  icon: Icon(
                    Icons.arrow_right,
                    color: widget.arrowColor ?? Colors.grey,
                  ),
                ),
              ],
            ),
            // Weekday headers
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 10),
              children:
                  ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                      .map(
                        (day) => Center(
                          child: Text(
                            day,
                            style:
                                widget.dayTextStyle ??
                                TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                      .toList(),
            ),
            // Calendar grid with selectable dates
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              shrinkWrap: true,

              itemCount: 42,
              itemBuilder: (_, index) {
                final date = calendarDays[index];
                final isCurrentMonth = date.month == displayedMonth.month;
                final isSelected =
                    date.year == selectedDate.year &&
                    date.month == selectedDate.month &&
                    date.day == selectedDate.day;
                final isFocusDate =
                    date.year == focusSelectedDate.year &&
                    date.month == focusSelectedDate.month &&
                    date.day == focusSelectedDate.day;

                return Focus(
                  focusNode: dateFocusNode,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        focusSelectedDate = date;
                        widget.onDateSelected(date);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            isCurrentMonth
                                ? (isSelected
                                    ? widget.selectedColor ?? Colors.blue
                                    : widget.unSelectedColor ??
                                        Colors.transparent)
                                : widget.disabledColor ?? Colors.transparent,
                        border: Border.all(
                          color:
                              isFocusDate
                                  ? widget.borderColor ?? Colors.grey
                                  : Colors.transparent,
                          width: widget.borderWidth ?? 1.0,
                        ),
                        borderRadius:
                            widget.borderRadius ?? BorderRadius.circular(30),
                      ),
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          color:
                              isCurrentMonth
                                  ? (isSelected
                                      ? widget.textSelectedColor ?? Colors.white
                                      : widget.textColor ?? Colors.black)
                                  : widget.textDisabledColor ?? Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------- Widget ---------------------------------------------------->

  @override
  Widget build(BuildContext context) {
    // Builds the main widget for the calendar UI.
    // Depending on the state, it either shows the year picker, month picker, or date picker.
    return Center(
      child:
          isMonthYearPickerOpen
              ? (isDecadePickerOpen
                  ? buildYearPicker() // If decade picker is open, show the year picker.
                  : buildMonthPicker()) // Otherwise, show the month picker.
              : buildDatePicker(), // Default to showing the date picker.
    );
  }

  @override
  void dispose() {
    // Disposes all focus nodes to free up resources and avoid memory leaks.

    // Dispose focus node for the left arrow button in the date picker.
    arrowLeftFocusNode.dispose();

    // Dispose focus node for the right arrow button in the date picker.
    arrowRightFocusNode.dispose();

    // Dispose focus node for the month/year text in the date picker.
    monthYearFocusNode.dispose();

    // Dispose focus node for individual date cells in the date picker.
    dateFocusNode.dispose();

    // Dispose focus node for the left arrow button in the month picker.
    arrowLeftMonthFocusNode.dispose();

    // Dispose focus node for the right arrow button in the month picker.
    arrowRightMonthFocusNode.dispose();

    // Dispose focus node for the year text in the month picker.
    yearFocusNode.dispose();

    // Dispose focus node for the month grid in the month picker.
    monthFocusNode.dispose();

    // Dispose focus node for the year grid in the year picker.
    yearGridFocusNode.dispose();

    // Dispose focus node for the left arrow button in the year picker.
    arrowLeftYearFocusNode.dispose();

    // Dispose focus node for the right arrow button in the year picker.
    arrowRightYearFocusNode.dispose();

    // Call the superclass dispose method to clean up other resources.
    super.dispose();
  }
}
