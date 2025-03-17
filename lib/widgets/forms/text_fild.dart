import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(String?) onChanged;

  const ProfileTextField({super.key, 
    required this.label,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: label,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person, color: Colors.blue),
      ),
      onChanged: (newValue) {
      if (newValue != null) {
        onChanged(newValue);
      }
    },
    );
  }
}
