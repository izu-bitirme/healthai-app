import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ProfileDropdown extends StatelessWidget {
  final String label;
  final String value;
  final Function(String?) onChanged;

  const ProfileDropdown({super.key, 
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      name: label,
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: [
        "Junior Full Stack Developer",
        "Senior Full Stack Developer",
        "Software Engineer"
      ]
          .map((position) => DropdownMenuItem(
                value: position,
                child: Text(position),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
