import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class ProfileDatePicker extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(String) onChanged;

  const ProfileDatePicker({super.key, 
    required this.label,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: label,
      controller: controller,
      inputType: InputType.date,
      format: DateFormat("dd MMMM yyyy"),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
      ),
      onChanged: (value) {
        if (value != null) {
          String formattedDate = "${value.day} ${_getMonth(value.month)} ${value.year}";
          onChanged(formattedDate);
        }
      },
    );
  }

  String _getMonth(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }
}
