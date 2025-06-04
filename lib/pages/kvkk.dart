import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/constants/app_respons.dart';
import 'package:healthai/constants/app_text.dart';
import 'package:healthai/providers/kvkk_provider.dart';
import 'package:healthai/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class KVKKPage extends StatelessWidget {
  const KVKKPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final kvkkProvider = Provider.of<KvkkProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("KVKK Aydınlatma Metni"),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: responsive.widthFactor(0.05),
          vertical: responsive.heightFactor(0.02),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeaderSection(responsive),
            SizedBox(height: responsive.heightFactor(0.03)),

            // Content Section
            _buildContentSection(responsive),
            SizedBox(height: responsive.heightFactor(0.04)),

            // Checkbox Section
            _buildCheckboxSection(responsive),
            SizedBox(height: responsive.heightFactor(0.04)),

            // Button Section
            _buildButtonSection(context, responsive),
            SizedBox(height: responsive.heightFactor(0.04)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(Responsive responsive) {
    return Container(
      padding: EdgeInsets.all(responsive.widthFactor(0.04)),
      decoration: BoxDecoration(
        color: const Color(0xFF6347EB).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.privacy_tip_rounded,
            color: const Color(0xFF6347EB),
            size: responsive.widthFactor(0.08),
          ),
          SizedBox(width: responsive.widthFactor(0.03)),
          Expanded(
            child: Text(
              'Kişisel Verilerin Korunması Kanunu (KVKK)',
              style: TextStyle(
                fontSize: responsive.fontSize(18),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF6347EB),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(Responsive responsive) {
    return Container(
      padding: EdgeInsets.all(responsive.widthFactor(0.04)),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Text(
        kvkkText,
        style: TextStyle(
          fontSize: responsive.fontSize(15),
          height: 1.5,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildCheckboxSection(Responsive responsive) {
    return Consumer<KvkkProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.all(responsive.widthFactor(0.03)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: provider.isAccepted,
                  activeColor: const Color(0xFF6347EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (bool? value) {
                    if (value == true) {
                      provider.acceptKvkk();
                    } else {
                      provider.declineKvkk();
                    }
                  },
                ),
              ),
              Expanded(
                child: Text(
                  'KVKK metnini okudum ve kabul ediyorum',
                  style: TextStyle(
                    fontSize: responsive.fontSize(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtonSection(BuildContext context, Responsive responsive) {
    return Consumer<KvkkProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  provider.isAccepted
                      ? const Color(0xFF6347EB)
                      : Colors.grey[400],
              padding: EdgeInsets.symmetric(
                vertical: responsive.heightFactor(0.02),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            onPressed:
                provider.isAccepted
                    ? () {
                      Navigator.pop(context);
                    }
                    : null,
            child: Text(
              'Onayla ve Devam Et',
              style: TextStyle(
                fontSize: responsive.fontSize(16),
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}
