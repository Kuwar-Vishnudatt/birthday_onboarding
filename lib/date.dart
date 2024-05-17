import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateSelectionPage extends StatefulWidget {
  @override
  _DateSelectionPageState createState() => _DateSelectionPageState();
}

class _DateSelectionPageState extends State<DateSelectionPage> {
  DateTime selectedDate = DateTime.now();
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;
  late FixedExtentScrollController yearController;

  @override
  void initState() {
    super.initState();
    monthController =
        FixedExtentScrollController(initialItem: selectedDate.month - 1);
    dayController =
        FixedExtentScrollController(initialItem: selectedDate.day - 1);
    yearController =
        FixedExtentScrollController(initialItem: selectedDate.year - 1994);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Progress Bar and Screen Number
          // ... (same as provided in your code) ...
          const SizedBox(height: 20),
          // Animated Date Picker
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Month Picker
              _buildPicker(
                  monthController, ['January', 'February', 'March', 'April'],
                  (int index) {
                setState(() {
                  selectedDate =
                      DateTime(selectedDate.year, index + 1, selectedDate.day);
                });
              }),
              // Day Picker
              _buildPicker(dayController,
                  List<String>.generate(31, (index) => '${index + 1}'),
                  (int index) {
                setState(() {
                  selectedDate = DateTime(
                      selectedDate.year, selectedDate.month, index + 1);
                });
              }),
              // Year Picker
              _buildPicker(yearController,
                  List<String>.generate(7, (index) => '${1994 + index}'),
                  (int index) {
                setState(() {
                  selectedDate = DateTime(
                      1994 + index, selectedDate.month, selectedDate.day);
                });
              }),
            ],
          ),
          const SizedBox(height: 20),
          // Continue Button
          // ... (same as provided in your code) ...
        ],
      ),
    );
  }

  Widget _buildPicker(FixedExtentScrollController controller,
      List<String> items, ValueChanged<int> onSelectedItemChanged) {
    return Expanded(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: CupertinoPicker(
          scrollController: controller,
          itemExtent: 32,
          onSelectedItemChanged: onSelectedItemChanged,
          children: items.map((String value) {
            return Center(child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}
