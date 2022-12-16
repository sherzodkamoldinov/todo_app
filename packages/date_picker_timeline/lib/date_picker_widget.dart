import 'package:date_picker_timeline/date_widget.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:date_picker_timeline/extra/style.dart';
import 'package:date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  /// Start Date in case user wants to show past dates
  /// If not provided calendar will start from the initialSelectedDate
  final DateTime startDate;

  /// Width of the selector
  final double width;

  /// Height of the selector
  final double height;


  /// Text color for the selected Date
  final Color selectedTextColor;

  /// Background color for the selector
  final Color selectionColor;

  /// Text Color for the deactivated dates
  final Color deactivatedColor;

  /// TextStyle for Month Value
  final TextStyle monthTextStyle;

  /// TextStyle for day Value
  final TextStyle dayTextStyle;

  /// TextStyle for the date Value
  final TextStyle dateTextStyle;

  /// Current Selected Date
  final DateTime? /*?*/ initialSelectedDate;

  /// Contains the list of inactive dates.
  /// All the dates defined in this List will be deactivated
  final List<DateTime>? inactiveDates;

  /// Contains the list of active dates.
  /// Only the dates in this list will be activated.
  final List<DateTime>? activeDates;

  /// Callback function for when a different date is selected
  final DateChangeListener? onDateChange;

  /// Max limit up to which the dates are shown.
  /// Days are counted from the startDate
  final int daysCount;

  /// Locale for the calendar default: en_us
  final String locale;

  final PageController _controller = PageController();

  final ValueChanged? onPageChanged;

  DatePicker(
    this.startDate, {
    Key? key,
    this.onPageChanged,
    this.width = 60,
    this.height = 70,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.deactivatedColor = AppColors.defaultDeactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 500,
    this.onDateChange,
    this.locale = "en_US",
  })  : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time."),
        assert(daysCount > 7, "Days should be large then 7");

  @override
  State<StatefulWidget> createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _currentDate;


  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;

  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedMonthStyle;
  late final TextStyle deactivatedDayStyle;

  int currentPage = 0;

  @override
  void initState() {
    // Init the calendar locale
    initializeDateFormatting(widget.locale, null);
    // Set initial Values
    _currentDate = widget.initialSelectedDate;


    this.selectedDateStyle = widget.dateTextStyle.copyWith(color: widget.selectedTextColor);
    this.selectedMonthStyle = widget.monthTextStyle.copyWith(color: widget.selectedTextColor);
    this.selectedDayStyle = widget.dayTextStyle.copyWith(color: widget.selectedTextColor);

    this.deactivatedDateStyle = widget.dateTextStyle.copyWith(color: widget.deactivatedColor);
    this.deactivatedMonthStyle = widget.monthTextStyle.copyWith(color: widget.deactivatedColor);
    this.deactivatedDayStyle = widget.dayTextStyle.copyWith(color: widget.deactivatedColor);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                widget._controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
              },
              icon: Icon(Icons.keyboard_arrow_left_rounded, color: Colors.white.withOpacity(0.7)),
            ),
            Column(
              children: [
                Text(DateFormat('MMMM').format(widget.startDate.add(Duration(days: currentPage * 7))), style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7))),
                SizedBox(height: 7),
                Text(widget.startDate.add(Duration(days: currentPage * 7)).year.toString(), style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7))),
              ],
            ),
            IconButton(
              onPressed: () {
                widget._controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
              },
              icon: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white.withOpacity(0.7)),
            ),
          ],
        ),
        Container(
          height: widget.height,
          child: PageView.builder(
            onPageChanged: (page) {
              widget.onPageChanged?.call(page);
              currentPage = page;
              setState(() {});
              print(page);
            },
            itemCount: (widget.daysCount ~/ 7) + 1,
            scrollDirection: Axis.horizontal,
            controller: widget._controller,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              index = index * 7;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(7, (newIndex) {
                    // get the date object based on the index position
                    // if widget.startDate is null then use the initialDateValue
                    DateTime date;
                    DateTime _date = widget.startDate.add(Duration(days: index + newIndex));
                    date = new DateTime(_date.year, _date.month, _date.day);
                    bool isDeactivated = false;
                    // check if this date needs to be deactivated for only DeactivatedDates
                    if (widget.inactiveDates != null) {
//            print("Inside Inactive dates.");
                      for (DateTime inactiveDate in widget.inactiveDates!) {
                        if (_compareDate(date, inactiveDate)) {
                          isDeactivated = true;
                          break;
                        }
                      }
                    }

                    // check if this date needs to be deactivated for only ActivatedDates
                    if (widget.activeDates != null) {
                      isDeactivated = true;
                      for (DateTime activateDate in widget.activeDates!) {
                        // Compare the date if it is in the
                        if (_compareDate(date, activateDate)) {
                          isDeactivated = false;
                          break;
                        }
                      }
                    }

                    // Check if this date is the one that is currently selected
                    bool isSelected = _currentDate != null ? _compareDate(date, _currentDate!) : false;

                    // Return the Date Widget
                    return Expanded(
                      child: DateWidget(
                        activeWidget: isDeactivated,
                        date: date,
                        monthTextStyle: isDeactivated
                            ? deactivatedMonthStyle
                            : isSelected
                                ? selectedMonthStyle
                                : widget.monthTextStyle,
                        dateTextStyle: isDeactivated
                            ? deactivatedDateStyle
                            : isSelected
                                ? selectedDateStyle
                                : widget.dateTextStyle,
                        dayTextStyle: isDeactivated
                            ? deactivatedDayStyle
                            : isSelected
                                ? selectedDayStyle
                                : widget.dayTextStyle,
                        width: widget.width,
                        locale: widget.locale,
                        selectionColor: isSelected ? widget.selectionColor : Colors.black87,
                        onDateSelected: (selectedDate) {
                          // Don't notify listener if date is deactivated
                          if (isDeactivated) return;
                    
                          // A date is selected
                          if (widget.onDateChange != null) {
                            widget.onDateChange!(selectedDate);
                          }
                          setState(() {
                            _currentDate = selectedDate;
                          });
                        }, activeWidgetIndecatorColor: widget.selectionColor,
                      ),
                    );
                  })
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  /// Helper function to compare two dates
  /// Returns True if both dates are the same
  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;
  }
}
