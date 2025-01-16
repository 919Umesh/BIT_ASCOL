import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Developer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Image
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/first2.jpg'),
              ),
            ),
            const SizedBox(height: 20),
            Tooltip(
                message: 'Visit Website',
                child: IconButton(
                    onPressed: () {
                      _launchURL('https://umeshweb-954c0.web.app/');
                    },
                    icon: const Icon(EvaIcons.globe2))),
            // Developer Name
            const Text(
              'Umesh Shahi Thakuri',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Developer Title
            const Text(
              'Flutter Developer',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            // Bio Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'Passionate Flutter developer with 5+ years of experience in mobile app development. Specialized in creating beautiful and performant cross-platform applications.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Skills Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Skills',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildSkillChip('Flutter'),
                      _buildSkillChip('Dart'),
                      _buildSkillChip('Firebase'),
                      _buildSkillChip('REST API'),
                      _buildSkillChip('Git'),
                      _buildSkillChip('UI/UX'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Contact Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Contact Me',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(
                        icon:EvaIcons.emailOutline,
                        onPressed: () =>
                            _launchURL('mailto:thakuriumesh919@gmail.com'),
                      ),
                      _buildSocialButton(
                        icon: EvaIcons.github,
                        onPressed: () =>
                            _launchURL('https://github.com/919Umesh'),
                      ),
                      _buildSocialButton(
                        icon: EvaIcons.phoneCall,
                        onPressed: () => _launchDialer('9868732774'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
  Future<void> _launchDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch $phoneUri';
      }
    } catch (e) {
      print('Error: $e');
      throw 'Could not launch $phoneUri';
    }
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        iconSize: 30,
        color: Colors.blue,
      ),
    );
  }
}
