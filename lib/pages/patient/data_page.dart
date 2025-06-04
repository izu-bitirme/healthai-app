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
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: const Text(
            'Kişisel Değerlendirme',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color(0xFF2D3748),
            ),
          ),
          leading: const Center(),
          actions: const [],
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (provider.currentStep + 1) / 6,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF6347EB),
              ),
              minHeight: 5,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Step Labels
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: List.generate(
              6,
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
              if (index != provider.currentStep) {
                pageController.jumpToPage(provider.currentStep);
              }
            },
            children: const [
              FullNameForm(),
              HeightInputForm(),
              WeightInputForm(),
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
                        side: const BorderSide(
                          color: Color(0xFF6347EB),
                          width: 1.5,
                        ),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Geri',
                      style: TextStyle(
                        color: Color(0xFF6347EB),
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
                      pageController.animateToPage(
                        provider.currentStep,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF6347EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
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
    final isCurrent = currentStep == stepIndex;
    final labels = ['Ad', 'Boy', 'Kilo', 'Doğum', 'Kan', 'Uyku'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:
                  isActive ? const Color(0xFF6347EB) : const Color(0xFFE7E1FF),
              shape: BoxShape.circle,
              border:
                  isCurrent
                      ? Border.all(color: const Color(0xFF6347EB), width: 2)
                      : null,
            ),
            child: Center(
              child: Text(
                '${stepIndex + 1}',
                style: TextStyle(
                  color: isActive ? Colors.white : const Color(0xFF6347EB),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            labels[stepIndex],
            style: TextStyle(
              color:
                  isActive ? const Color(0xFF2D3748) : const Color(0xFFA0AEC0),
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
              color: const Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Resmi belgelerde göründüğü şekilde tam adınızı yazın.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF718096)),
          ),
          const SizedBox(height: 32),
          _buildTextField(label: 'Tam Ad', controller: controller),
        ],
      ),
    );
  }
}

Widget _buildTextField({
  required String label,
  ValueChanged<String>? onChanged,
  String? initialValue,
  String? suffixText,
  TextInputType? keyboardType,
  required TextEditingController controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Color(0xFF4A5568),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        enabled: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF6347EB), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          suffixText: suffixText,
          suffixStyle: const TextStyle(
            color: Color(0xFF718096),
            fontWeight: FontWeight.bold,
          ),
        ),
        style: const TextStyle(fontSize: 16, color: Color(0xFF2D3748)),
      ),
    ],
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
              color: const Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Doğru değerlendirme için boyunuzu girin.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF718096)),
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
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
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
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6347EB) : Colors.white,
          borderRadius:
              unit == 'cm'
                  ? const BorderRadius.horizontal(left: Radius.circular(12))
                  : const BorderRadius.horizontal(right: Radius.circular(12)),
        ),
        child: Center(
          child: Text(
            unit,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF4A5568),
              fontWeight: FontWeight.w600,
              fontSize: 16,
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
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
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
                              ? const Color(0xFF6347EB)
                              : const Color(0xFFA0AEC0),
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
            padding: const EdgeInsets.only(right: 24),
            child: Text(
              provider.heightUnit,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF718096),
                fontWeight: FontWeight.w600,
              ),
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
              color: const Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Doğru değerlendirme için güncel kilonuzu girin.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF718096)),
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
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
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
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6347EB) : Colors.white,
          borderRadius:
              unit == 'kg'
                  ? const BorderRadius.horizontal(left: Radius.circular(12))
                  : const BorderRadius.horizontal(right: Radius.circular(12)),
        ),
        child: Center(
          child: Text(
            unit,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF4A5568),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
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
              color: const Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Doğru değerlendirme için doğum tarihinizi girin.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF718096)),
          ),
          const SizedBox(height: 32),

          // Date Picker Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
            ),
            child: ListTile(
              onTap: () => _selectDate(context, provider),
              leading: const Icon(
                Icons.calendar_today,
                color: Color(0xFF6347EB),
              ),
              title: Text(
                '${provider.birthDate.day}/${provider.birthDate.month}/${provider.birthDate.year}',
                style: const TextStyle(fontSize: 16, color: Color(0xFF2D3748)),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFFA0AEC0),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Age Display
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE7E1FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Yaşınız: $adjustedAge',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF6347EB),
                  fontWeight: FontWeight.bold,
                ),
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
              primary: Color(0xFF6347EB),
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
              color: const Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Doğru değerlendirme için kan grubunuzu seçin.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF718096)),
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
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6347EB) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF6347EB) : const Color(0xFFE2E8F0),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            type,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : const Color(0xFF2D3748),
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
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6347EB) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF6347EB) : const Color(0xFFE2E8F0),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : const Color(0xFF2D3748),
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
              color: const Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Son zamanlardaki uyku düzeninizi değerlendirin.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF718096)),
          ),
          const SizedBox(height: 32),

          // Rating Display
          Center(
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E1FF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${provider.sleepRating}',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6347EB),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  ratingLabels[provider.sleepRating - 1],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF2D3748),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Rating Slider
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: const Color(0xFF6347EB),
                inactiveTrackColor: const Color(0xFFE2E8F0),
                thumbColor: const Color(0xFF6347EB),
                overlayColor: const Color(0x1A6347EB),
                valueIndicatorColor: const Color(0xFF6347EB),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              ),
              child: Slider(
                value: provider.sleepRating.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: ratingLabels[provider.sleepRating - 1],
                onChanged: (value) {
                  provider.setSleepRating(value.round());
                },
              ),
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
                            ? const Color(0xFF6347EB)
                            : const Color(0xFFA0AEC0),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 40),

          // Additional Info
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE7E1FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Günde 7-8 saat uyku önerilir',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6347EB),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
