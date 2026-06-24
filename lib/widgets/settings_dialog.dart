import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/global_settings.dart';
import '../theme/app_colors.dart';
import 'three_d_button.dart';
import 'tutorial_dialog.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  double _voiceVol = GlobalSettings.voiceVolume;
  double _sfxVol = GlobalSettings.sfxVolume;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    Color cardColor = Theme.of(context).cardColor;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: Color(0xFFF0F4F8), shape: BoxShape.circle),
                child: const Icon(Icons.settings, size: 36, color: Color(0xFF667eea)),
              ),
              const SizedBox(height: 16),
              Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
              Text('ပြင်ဆင်မှုများ', style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
              const SizedBox(height: 24),
              _buildVolumeControl(
                icon: Icons.record_voice_over,
                title: "Voice Volume",
                subTitle: "အသံ အတိုးအကျယ်",
                value: _voiceVol,
                onChanged: (val) {
                  setState(() => _voiceVol = val);
                  GlobalSettings.voiceVolume = val;
                },
              ),
              const SizedBox(height: 12),
              _buildVolumeControl(
                icon: Icons.music_note,
                title: "Sound Effects",
                subTitle: "အသံ အထူးပြုလုပ်ချက်",
                value: _sfxVol,
                onChanged: (val) {
                  setState(() => _sfxVol = val);
                  GlobalSettings.sfxVolume = val;
                },
              ),
              const Divider(height: 32),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.indigo.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: Colors.indigo),
                ),
                title: Text("Dark Mode", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                subtitle: const Text("အမှောင်စနစ်", style: TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: Switch(
                  value: isDark,
                  activeColor: const Color(0xFF667eea),
                  onChanged: (val) { GlobalSettings.toggleTheme(); },
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.school, color: Colors.amber),
                ),
                title: Text("Watch Tutorial", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                subtitle: const Text("လမ်းညွှန် ကြည့်ရန်", style: TextStyle(fontSize: 12, color: Colors.grey)),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(context: context, builder: (context) => const TutorialDialog());
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.info, color: Colors.blueGrey),
                ),
                title: Text("About", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                subtitle: const Text("အကြောင်းအရာ", style: TextStyle(fontSize: 12, color: Colors.grey)),
                onTap: () {
                  Navigator.pop(context);
                  _showAuthorInfo(context);
                },
              ),
              const SizedBox(height: 24),
              ThreeDButton(
                onPressed: () {
                  GlobalSettings.saveVolumes();
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: const Color(0xFF667eea).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
                  ),
                  child: const Center(child: Text("Close", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVolumeControl({required IconData icon, required String title, required String subTitle, required double value, required Function(double) onChanged}) {
    Color textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                Text(subTitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ],
        ),
        Slider(value: value, min: 0.0, max: 1.0, activeColor: const Color(0xFF667eea), inactiveColor: Colors.grey.shade200, onChanged: onChanged),
      ],
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  void _showAuthorInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.info_outline, size: 40, color: Color(0xFF667eea)),
              const SizedBox(height: 16),
              const Text('Chin Chin Chinese', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const Text('Version 1.0.0', style: TextStyle(color: Colors.grey, fontSize: 14)),
              const Divider(height: 32),
              _buildInfoRow(Icons.code, "Developer", "賴泳在 (YUNG-TSAI LAI)"),
              _buildInfoRow(Icons.translate, "Translation", "ChinQing in Taiwan (林素青)"),
              const SizedBox(height: 16),
              const Text(
                '• Code: MIT License\n• Assets: CC BY-NC-ND 4.0\n© 2025 All Rights Reserved.',
                style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => _launchURL('https://lai2570.github.io/Burmese_language_app/privacy'),
                    child: const Text("Privacy Policy", style: TextStyle(color: Color(0xFF667eea), fontSize: 12, decoration: TextDecoration.underline)),
                  ),
                  const Text("|", style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () => _launchURL('https://lai2570.github.io/Burmese_language_app/terms'),
                    child: const Text("Terms & Conditions", style: TextStyle(color: Color(0xFF667eea), fontSize: 12, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ThreeDButton(
                onPressed: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(12)),
                  child: const Center(child: Text("Close", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF94A3B8)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              Text(content, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
            ],
          ),
        ],
      ),
    );
  }
}
