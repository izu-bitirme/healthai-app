import 'package:flutter/material.dart';
import 'package:healthai/providers/widgets_providers.dart';
import 'package:provider/provider.dart';

class ModernImagePicker extends StatelessWidget {
  const ModernImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagePickerProvider>(context);
    return GestureDetector(
      onTap: () async {
        await imageProvider.pickImage();
      },
      child: CircleAvatar(
        radius: 50,
        backgroundImage: imageProvider.image == null
            ? AssetImage("assets/images/auth/profile.png") : FileImage(imageProvider.image!),
      ),
    );
  }
}
