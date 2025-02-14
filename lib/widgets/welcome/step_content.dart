import 'package:flutter/material.dart';

class StepContent extends StatelessWidget {
  const StepContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: Column(
        children: [
          Image.asset('assets/images/step1.png'),
          const Text('Step 1', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          
      ]),
      
        
    );
  }
}