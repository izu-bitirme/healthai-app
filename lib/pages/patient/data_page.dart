import 'package:flutter/material.dart';

class DataCollectionScreen extends StatelessWidget {
  const DataCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Kişisel Değerlendirme',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Atla',
              style: TextStyle(
                color: Colors.blue[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: const StepperBody(),
    );
  }
}

class StepperBody extends StatefulWidget {
  const StepperBody({super.key});

  @override
  State<StepperBody> createState() => _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 6) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / 7,
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
            children: List.generate(7, (index) => _buildStepLabel(index)),
          ),
        ),
        
        // Form Content
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
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
              if (_currentStep > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: _prevStep,
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
              if (_currentStep > 0) const SizedBox(width: 16),
              Expanded(
                flex: _currentStep == 0 ? 1 : 2,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentStep == 6 ? 'Tamamla' : 'İleri',
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

  Widget _buildStepLabel(int stepIndex) {
    final isActive = _currentStep >= stepIndex;
    final labels = [
      'Ad', 'Boy', 'Kilo', 'Kardeş', 
      'Doğum', 'Kan', 'Uyku'
    ];
    
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

// Modern Form Widgets
class FullNameForm extends StatelessWidget {
  const FullNameForm({super.key});

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          _buildTextField(label: 'Tam Ad'),
        ],
      ),
    );
  }
}

class HeightInputForm extends StatefulWidget {
  const HeightInputForm({super.key});

  @override
  State<HeightInputForm> createState() => _HeightInputFormState();
}

class _HeightInputFormState extends State<HeightInputForm> {
  String _unit = 'cm';
  int _selectedHeight = 170;
  final FixedExtentScrollController _scrollController = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          
          // Unit Selector
          _buildUnitSelector(),
          const SizedBox(height: 24),
          
          // Height Picker
          _buildHeightPicker(),
        ],
      ),
    );
  }

  Widget _buildUnitSelector() {
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
            child: _buildUnitButton('cm', _unit == 'cm'),
          ),
          Expanded(
            child: _buildUnitButton('inch', _unit == 'inch'),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitButton(String unit, bool isSelected) {
    return InkWell(
      onTap: () => setState(() => _unit = unit),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: unit == 'cm' 
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

  Widget _buildHeightPicker() {
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
              controller: _scrollController,
              itemExtent: 50,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedHeight = _unit == 'cm' ? 140 + index : _cmToInch(140 + index);
                });
              },
              children: List.generate(80, (index) {
                final height = _unit == 'cm' ? 140 + index : _cmToInch(140 + index);
                return Center(
                  child: Text(
                    height.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      color: height == _selectedHeight ? Colors.blue : Colors.grey[600],
                      fontWeight: height == _selectedHeight ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              _unit,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _cmToInch(int cm) => (cm * 0.393701).round();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class WeightInputForm extends StatefulWidget {
  const WeightInputForm({super.key});

  @override
  State<WeightInputForm> createState() => _WeightInputFormState();
}

class _WeightInputFormState extends State<WeightInputForm> {
  String _unit = 'kg';
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          
          // Unit Selector
          _buildUnitSelector(),
          const SizedBox(height: 24),
          
          // Weight Input
          _buildTextField(
            label: 'Kilo',
            controller: _weightController,
            suffixText: _unit,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildUnitSelector() {
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
            child: _buildUnitButton('kg', _unit == 'kg'),
          ),
          Expanded(
            child: _buildUnitButton('lb', _unit == 'lb'),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitButton(String unit, bool isSelected) {
    return InkWell(
      onTap: () => setState(() => _unit = unit),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: unit == 'kg' 
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          _buildTextField(
            label: 'Kardeş Sayısı',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}

class BirthDateForm extends StatefulWidget {
  const BirthDateForm({super.key});

  @override
  State<BirthDateForm> createState() => _BirthDateFormState();
}

class _BirthDateFormState extends State<BirthDateForm> {
  DateTime _selectedDate = DateTime.now().subtract(const Duration(days: 365 * 20));
  int _age = 20;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
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
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _age = DateTime.now().year - picked.year;
        if (DateTime.now().month < picked.month || 
            (DateTime.now().month == picked.month && DateTime.now().day < picked.day)) {
          _age--;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
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
              onTap: () => _selectDate(context),
              leading: const Icon(Icons.calendar_today, color: Colors.blue),
              title: Text(
                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                style: const TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Age Display
          Center(
            child: Text(
              'Yaşınız: $_age',
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
}

class BloodTypeInputForm extends StatefulWidget {
  const BloodTypeInputForm({super.key});

  @override
  State<BloodTypeInputForm> createState() => _BloodTypeInputFormState();
}

class _BloodTypeInputFormState extends State<BloodTypeInputForm> {
  String? _selectedBloodType;
  bool _isRhPositive = true;

  final List<String> _bloodTypes = ['A', 'B', 'AB', 'O'];

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          
          // Blood Type Selection
          Center(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _bloodTypes.map((type) {
                return _buildBloodTypeOption(type);
              }).toList(),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Rh Factor Selection
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRhFactorOption('Rh+', true),
                const SizedBox(width: 16),
                _buildRhFactorOption('Rh-', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodTypeOption(String type) {
    final isSelected = _selectedBloodType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedBloodType = type),
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
          border: isSelected 
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

  Widget _buildRhFactorOption(String label, bool isPositive) {
    final isSelected = _isRhPositive == isPositive;
    return GestureDetector(
      onTap: () => setState(() => _isRhPositive = isPositive),
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
          border: isSelected 
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

class SleepRatingForm extends StatefulWidget {
  const SleepRatingForm({super.key});

  @override
  State<SleepRatingForm> createState() => _SleepRatingFormState();
}

class _SleepRatingFormState extends State<SleepRatingForm> {
  int _selectedRating = 3;
  final List<String> _ratingLabels = [
    'Çok Kötü',
    'Kötü',
    'Orta',
    'İyi',
    'Mükemmel'
  ];

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          
          // Rating Display
          Center(
            child: Column(
              children: [
                Text(
                  '$_selectedRating',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _ratingLabels[_selectedRating - 1],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Rating Slider
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Slider(
              value: _selectedRating.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: _ratingLabels[_selectedRating - 1],
              onChanged: (value) {
                setState(() {
                  _selectedRating = value.round();
                });
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
                    color: _selectedRating == index + 1 
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

// Reusable Widgets
Widget _buildTextField({
  required String label,
  TextEditingController? controller,
  String? suffixText,
  TextInputType? keyboardType,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
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
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      suffixText: suffixText,
      suffixStyle: TextStyle(
        color: Colors.grey[600],
        fontWeight: FontWeight.bold,
      ),
    ),
    style: const TextStyle(
      fontSize: 16,
      color: Colors.black87,
    ),
  );
}