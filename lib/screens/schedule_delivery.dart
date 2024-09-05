import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../themes/colors.dart';

class ScheduleFuelDeliveryScreen extends StatefulWidget {
  const ScheduleFuelDeliveryScreen({super.key});

  @override
  State<ScheduleFuelDeliveryScreen> createState() =>
      _ScheduleFuelDeliveryScreenState();
}

class _ScheduleFuelDeliveryScreenState
    extends State<ScheduleFuelDeliveryScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController addressController =
      TextEditingController(text: 'Ayeduase st kotei');

  String? selectedFuelType = 'Petrol';
  String? selectedQuantity = '1 Liter';

  final List<String> fuelTypes = ['Petrol', 'Diesel', 'Gas'];
  final List<String> quantities = [
    '1 Liter',
    '2 Liters',
    '3 Liters',
    '4 Liters',
    '5 Liters'
  ];

  final TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
  final TimeOfDay endTime = const TimeOfDay(hour: 16, minute: 0);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      if (_isTimeWithinRange(pickedTime)) {
        setState(() {
          selectedTime = pickedTime;
        });
      } else {
        _showTimeError();
      }
    }
  }

  bool _isTimeWithinRange(TimeOfDay time) {
    // Convert TimeOfDay to DateTime for comparison
    final now = DateTime.now();
    final timeAsDateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final startAsDateTime = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);
    final endAsDateTime =
        DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

    return timeAsDateTime.isAfter(startAsDateTime) &&
        timeAsDateTime.isBefore(endAsDateTime);
  }

  void _showTimeError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var textTheme = Theme.of(context).textTheme;
        return AlertDialog(
          title: Text(
            ' Time Error',
            style: textTheme.bodyLarge,
          ),
          content: Text(
            'Delivery times are between\n8 AM to 4 PM.',
            style: textTheme.bodyMedium,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    side: BorderSide(
                      color: KColors.primaryBlack,
                      width: 1.w,
                    )),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: textTheme.bodySmall,
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmSchedule() {
    // Logic to confirm and save the delivery schedule
    // For example, you might show a confirmation dialog or save the data to a database
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var textTheme = Theme.of(context).textTheme;
        return AlertDialog(
          title: Text(
            'Schedule Confirmed',
            style: textTheme.bodyLarge,
          ),
          content: Text(
            'Fuel delivery is scheduled for\n\n${DateFormat('EEEE, yyyy-MM-dd').format(selectedDate)} at ${selectedTime.format(context)}.\n\nAddress: ${addressController.text}\n\nFuel Type: $selectedFuelType\n\nQuantity: $selectedQuantity',
            style: textTheme.bodyMedium,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      side: BorderSide(
                          color: KColors.primaryWhite, width: .5.w))),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style:
                    textTheme.bodyMedium!.copyWith(color: KColors.primaryWhite),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 25.sp,
          ),
        ),
        title: Text('Fuel Delivery Schedule', style: textTheme.bodyLarge),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Delivery Date:',
                  style: textTheme.bodyLarge!
                      .copyWith(color: KColors.primaryBlack.withOpacity(.7))),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      DateFormat('EEEE, yyyy-MM-dd').format(selectedDate),
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      size: 25.sp,
                    ),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text('Select Delivery Time:',
                  style: textTheme.bodyLarge!
                      .copyWith(color: KColors.primaryBlack.withOpacity(.7))),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedTime.format(context),
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.access_time,
                      size: 25.sp,
                    ),
                    onPressed: () => _selectTime(context),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text('Delivery Address:',
                  style: textTheme.bodyLarge!
                      .copyWith(color: KColors.primaryBlack.withOpacity(.7))),
              SizedBox(height: 8.h),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  // border: OutlineInputBorder(),
                  hintText: 'Enter delivery address',
                  hintStyle: textTheme.bodySmall,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: KColors.primaryBlack,
                      width: 1.w,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: KColors.primaryBlack,
                      width: 1.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Select Fuel Type:',
                      style: textTheme.bodyLarge!.copyWith(
                        color: KColors.primaryBlack.withOpacity(.7),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 85.w,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: DropdownButton<String>(
                      value: selectedFuelType,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFuelType = newValue!;
                        });
                      },
                      items: fuelTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Text('Select Quantity:',
                        style: textTheme.bodyLarge!.copyWith(
                            color: KColors.primaryBlack.withOpacity(.7))),
                  ),
                  Container(
                    height: 40.h,
                    width: 90.w,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: DropdownButton<String>(
                      value: selectedQuantity,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedQuantity = newValue!;
                        });
                      },
                      items: quantities
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 95.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    backgroundColor: Colors.blue,
                    fixedSize: Size(MediaQuery.sizeOf(context).width, 45.h)),
                onPressed: _confirmSchedule,
                child: Text(
                  'Confirm Schedule',
                  style: textTheme.bodyLarge!
                      .copyWith(color: KColors.primaryWhite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
