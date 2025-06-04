import 'package:flutter/material.dart';
import 'package:healthai/providers/paition_data.dart';
import 'package:healthai/providers/patient_provider.dart';
import 'package:provider/provider.dart';

class DataCollectionScreen extends StatelessWidget {
  const DataCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DataProvider(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: const Text(
            'Kişisel Değerlendirme',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          leading: Center(),
          actions: [],
        ),
        body: const StepperBody(),
      ),
    );
  }
}

class StepperBody extends StatelessWidget {
  const StepperBody({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    final patientProvider = Provider.of<PatientProvider>(context);
    final pageController = PageController();

    return Column(
      children: [
        // Progress Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: LinearProgressIndicator(
            value: (provider.currentStep + 1) / 7,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 8),

        // Step Labels
        SizedBox(
          height: 60,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: List.generate(
              7,
              (index) => _buildStepLabel(index, provider.currentStep),
            ),
          ),
        ),

        // Form Content
        Expanded(
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              // This ensures the page view stays in sync with the provider's currentStep
              if (index != provider.currentStep) {
                pageController.jumpToPage(provider.currentStep);
              }
            },
            children: const [
              FullNameForm(),
              HeightInputForm(),
              WeightInputForm(),
              SiblingsForm(),
              BirthDateForm(),
              BloodTypeInputForm(),
              SleepRatingForm(),
            ],
          ),
        ),

        // Navigation Buttons
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              if (provider.currentStep > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: provider.prevStep,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.blue[600]!),
                    ),
                    child: Text(
                      'Geri',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              if (provider.currentStep > 0) const SizedBox(width: 16),
              Expanded(
                flex: provider.currentStep == 0 ? 1 : 2,
                child: ElevatedButton(
                  onPressed: () async {
                    if (provider.currentStep == 6) {
                      await patientProvider.submitPatintData(
                        height_before: provider.height,
                        weight: provider.weight,
                      );

                      Navigator.pushReplacementNamed(context, '/');
                    } else {
                      provider.nextStep();
                      // Animate to the next page
                      pageController.animateToPage(
                        provider.currentStep,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    provider.currentStep == 6 ? 'Tamamla' : 'İleri',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepLabel(int stepIndex, int currentStep) {
    final isActive = currentStep >= stepIndex;
    final labels = ['Ad', 'Boy', 'Kilo', 'Kardeş', 'Doğum', 'Kan', 'Uyku'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isActive ? Colors.blue : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${stepIndex + 1}',
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            labels[stepIndex],
            style: TextStyle(
              color: isActive ? Colors.blue : Colors.grey,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class FullNameForm extends StatelessWidget {
  const FullNameForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    final controller = TextEditingController(text: provider.fullName);

    controller.addListener(() {
      provider.setFullName(controller.text);
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Adınız nedir?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Resmi belgelerde göründüğü şekilde tam adınızı yazın.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),
          _buildTextField(label: 'Tam Ad', controller: controller),
        ],
      ),
    );
  }
}

// Update the _buildTextField widget to include onChanged and initialValue
Widget _buildTextField({
  required String label,
  ValueChanged<String>? onChanged,
  String? initialValue,
  String? suffixText,
  TextInputType? keyboardType,
  required TextEditingController
  controller, // This is the only declaration needed
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      suffixText: suffixText,
      suffixStyle: TextStyle(
        color: Colors.grey[600],
        fontWeight: FontWeight.bold,
      ),
    ),
    style: const TextStyle(fontSize: 16, color: Colors.black87),
  );
}

class HeightInputForm extends StatelessWidget {
  const HeightInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    final scrollController = FixedExtentScrollController(
      initialItem: (provider.height - 140).toInt(),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Boyunuz nedir?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Doğru değerlendirme için boyunuzu girin.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),

          // Unit Selector
          _buildUnitSelector(provider),
          const SizedBox(height: 24),

          // Height Picker
          _buildHeightPicker(provider, scrollController),
        ],
      ),
    );
  }

  Widget _buildUnitSelector(DataProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildUnitButton(
              'cm',
              provider.heightUnit == 'cm',
              provider,
            ),
          ),
          Expanded(
            child: _buildUnitButton(
              'inch',
              provider.heightUnit == 'inch',
              provider,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitButton(String unit, bool isSelected, DataProvider provider) {
    return InkWell(
      onTap: () => provider.setHeightUnit(unit),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius:
              unit == 'cm'
                  ? const BorderRadius.horizontal(left: Radius.circular(12))
                  : const BorderRadius.horizontal(right: Radius.circular(12)),
        ),
        child: Center(
          child: Text(
            unit,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeightPicker(
    DataProvider provider,
    FixedExtentScrollController scrollController,
  ) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ListWheelScrollView(
              controller: scrollController,
              itemExtent: 50,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                final height =
                    provider.heightUnit == 'cm'
                        ? 140 + index
                        : _cmToInch(140 + index);
                provider.setHeight(height.toDouble());
              },
              children: List.generate(80, (index) {
                final height =
                    provider.heightUnit == 'cm'
                        ? 140 + index
                        : _cmToInch(140 + index);
                return Center(
                  child: Text(
                    height.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      color:
                          height == provider.height
                              ? Colors.blue
                              : Colors.grey[600],
                      fontWeight:
                          height == provider.height
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              provider.heightUnit,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  int _cmToInch(int cm) => (cm * 0.393701).round();
}

class WeightInputForm extends StatelessWidget {
  const WeightInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    final controller = TextEditingController(text: provider.weight.toString());

    controller.addListener(() {
      final value = double.tryParse(controller.text) ?? provider.weight;
      provider.setWeight(value);
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kilonuz nedir?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Doğru değerlendirme için güncel kilonuzu girin.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),

          // Unit Selector
          _buildUnitSelector(provider),
          const SizedBox(height: 24),

          // Weight Input
          _buildTextField(
            label: 'Kilo',
            controller: controller,
            suffixText: provider.weightUnit,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildUnitSelector(DataProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildUnitButton(
              'kg',
              provider.weightUnit == 'kg',
              provider,
            ),
          ),
          Expanded(
            child: _buildUnitButton(
              'lb',
              provider.weightUnit == 'lb',
              provider,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitButton(String unit, bool isSelected, DataProvider provider) {
    return InkWell(
      onTap: () => provider.setWeightUnit(unit),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius:
              unit == 'kg'
                  ? const BorderRadius.horizontal(left: Radius.circular(12))
                  : const BorderRadius.horizontal(right: Radius.circular(12)),
        ),
        child: Center(
          child: Text(
            unit,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class SiblingsForm extends StatelessWidget {
  const SiblingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    final controller = TextEditingController(
      text: provider.siblings.toString(),
    );

    controller.addListener(() {
      final value = int.tryParse(controller.text) ?? provider.siblings;
      provider.setSiblings(value);
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kaç kardeşiniz var?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ailenizdeki kardeş sayısını belirtin.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),
          _buildTextField(
            label: 'Kardeş Sayısı',
            controller: controller,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}

class BirthDateForm extends StatelessWidget {
  const BirthDateForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    final age = DateTime.now().year - provider.birthDate.year;
    final adjustedAge =
        DateTime.now().isBefore(
              DateTime(
                DateTime.now().year,
                provider.birthDate.month,
                provider.birthDate.day,
              ),
            )
            ? age - 1
            : age;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Doğum tarihiniz nedir?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Doğru değerlendirme için doğum tarihinizi girin.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),

          // Date Picker Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              onTap: () => _selectDate(context, provider),
              leading: const Icon(Icons.calendar_today, color: Colors.blue),
              title: Text(
                '${provider.birthDate.day}/${provider.birthDate.month}/${provider.birthDate.year}',
                style: const TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),

          const SizedBox(height: 24),

          // Age Display
          Center(
            child: Text(
              'Yaşınız: $adjustedAge',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, DataProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != provider.birthDate) {
      provider.setBirthDate(picked);
    }
  }
}

class BloodTypeInputForm extends StatelessWidget {
  const BloodTypeInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    final bloodTypes = ['A', 'B', 'AB', 'O'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kan grubunuz nedir?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Doğru değerlendirme için kan grubunuzu seçin.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),

          // Blood Type Selection
          Center(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children:
                  bloodTypes.map((type) {
                    return _buildBloodTypeOption(
                      type,
                      provider.bloodType == type,
                      provider,
                    );
                  }).toList(),
            ),
          ),

          const SizedBox(height: 32),

          // Rh Factor Selection
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRhFactorOption('Rh+', provider.isRhPositive, provider),
                const SizedBox(width: 16),
                _buildRhFactorOption('Rh-', !provider.isRhPositive, provider),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodTypeOption(
    String type,
    bool isSelected,
    DataProvider provider,
  ) {
    return GestureDetector(
      onTap: () => provider.setBloodType(type),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border:
              isSelected
                  ? Border.all(color: Colors.blue, width: 2)
                  : Border.all(color: Colors.grey[300]!),
        ),
        child: Center(
          child: Text(
            type,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.grey[800],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRhFactorOption(
    String label,
    bool isSelected,
    DataProvider provider,
  ) {
    return GestureDetector(
      onTap: () => provider.setRhFactor(label == 'Rh+'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border:
              isSelected
                  ? Border.all(color: Colors.blue, width: 2)
                  : Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey[800],
          ),
        ),
      ),
    );
  }
}

class SleepRatingForm extends StatelessWidget {
  const SleepRatingForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    final ratingLabels = ['Çok Kötü', 'Kötü', 'Orta', 'İyi', 'Mükemmel'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Uyku kalitenizi nasıl değerlendirirsiniz?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Son zamanlardaki uyku düzeninizi değerlendirin.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),

          // Rating Display
          Center(
            child: Column(
              children: [
                Text(
                  '${provider.sleepRating}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ratingLabels[provider.sleepRating - 1],
                  style: const TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Rating Slider
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Slider(
              value: provider.sleepRating.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: ratingLabels[provider.sleepRating - 1],
              onChanged: (value) {
                provider.setSleepRating(value.round());
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.grey[300],
            ),
          ),

          const SizedBox(height: 24),

          // Rating Labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                return Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        provider.sleepRating == index + 1
                            ? Colors.blue
                            : Colors.grey,
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 40),

          // Additional Info
          const Center(
            child: Text(
              'Günde 7-8 saat uyku önerilir',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
