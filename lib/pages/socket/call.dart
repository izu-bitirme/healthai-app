import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';

class VoiceCallPage extends StatefulWidget {
  const VoiceCallPage({super.key});

  @override
  _VoiceCallPageState createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  bool isMuted = false;
  bool isSpeakerOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/doctor.png"),
            ),
            SizedBox(height: 20),
            Text(
              "John Doe",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Calling...",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _iconButton(
                  icon: Icons.mic_off,
                  label: "Mute",
                  isActive: isMuted,
                  onTap: () {
                    setState(() {
                      isMuted = !isMuted;
                    });
                  },
                ),
                SizedBox(width: 20),
                _iconButton(
                  icon: Icons.volume_up,
                  label: "Speaker",
                  isActive: isSpeakerOn,
                  onTap: () {
                    setState(() {
                      isSpeakerOn = !isSpeakerOn;
                    });
                  },
                ),
                SizedBox(width: 20),
                _iconButton(
                  icon: Icons.call_end,
                  label: "End Call",
                  color: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required String label,
    bool isActive = false,
    Color? color,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor: color ?? (isActive ? AppColors.primaryColor : Colors.grey[800]),
            radius: 30,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
