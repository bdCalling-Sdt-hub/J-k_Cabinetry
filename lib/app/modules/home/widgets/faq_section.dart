import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletText(
          "Questions? Please refer to our ",
          "FAQ",
          "https://jkcabinetryct.com/support",
        ),
        _buildBulletText(
          "Looking for a showroom? ",
          "Find one now.",
          "https://jkcabinetryct.com/support",
        ),
        const SizedBox(height: 8),
        const Text(
          "• Didn’t find your answer? Fill in the form below and we will get back to you as soon as possible.",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        _buildBulletText(
          "If you have any questions, comments or concerns please contact us at ",
          "sales@jkcabinetryct.com",
          "mailto:sales@jkcabinetryct.com",
        ),
      ],
    );
  }

  Widget _buildBulletText(String normalText, String linkText, String url) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ", style: TextStyle(fontSize: 16)),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black),
              children: [
                TextSpan(text: normalText),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () => _launchURL(url),
                    child: Text(linkText,
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}