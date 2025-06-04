import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';

class MoodSelector extends StatefulWidget {
  const MoodSelector({super.key});

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  final List<String> moods = ["Sad", "Tired", "Angry", "Normal", "Happy"];

  final List<String> emojis = ["😔", "😴", "😡", "🙂", "😁"];

  int selectedIndex = 1;
  double itemHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sliderHeight = screenHeight * 0.4;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "How are you\nfeeling today?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.08),
            SizedBox(
              height: sliderHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Mood labels (reversed order)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(moods.length, (index) {
                      final reversedIndex = moods.length - 1 - index;
                      return AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              selectedIndex == reversedIndex
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                          color:
                              selectedIndex == reversedIndex
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                        child: Text(moods[reversedIndex]),
                      );
                    }),
                  ),
                  const SizedBox(width: 15),
                  // Custom vertical slider (reversed)
                  GestureDetector(
                    onVerticalDragUpdate: (details) {
                      double drag = details.localPosition.dy;
                      int newIndex =
                          (drag / itemHeight)
                              .clamp(0, moods.length - 1)
                              .toInt();
                      // Reverse the index (0 becomes 4, 1 becomes 3, etc.)
                      int reversedIndex = moods.length - 1 - newIndex;
                      if (reversedIndex != selectedIndex) {
                        setState(() {
                          selectedIndex = reversedIndex;
                        });
                      }
                    },
                    child: SizedBox(
                      width: 70,
                      height: sliderHeight,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          // Background track (full height)
                          Positioned.fill(
                            child: Center(
                              child: Container(
                                width: 8,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          // Active track (fills from bottom based on selection)
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            top:
                                sliderHeight -
                                ((selectedIndex + 2) * itemHeight),
                            bottom: 0,
                            child: Container(
                              width: 8,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          // Slider handle (positioned based on reversed index)
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutBack,
                            top:
                                (moods.length - 1 - selectedIndex) * itemHeight,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 3,
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Emoji display (reversed order)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(emojis.length, (index) {
                      final reversedIndex = emojis.length - 1 - index;
                      return AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: selectedIndex == reversedIndex ? 1.3 : 1.0,
                        child: Text(
                          emojis[reversedIndex],
                          style: TextStyle(
                            fontSize: 28,
                            color:
                                selectedIndex == reversedIndex
                                    ? Colors.black
                                    : Colors.grey.shade400,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            // Selected mood indicator
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  "${moods[selectedIndex]} ${emojis[selectedIndex]}",
                  key: ValueKey<int>(selectedIndex),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
