// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:learn/widgets/language_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Language menu (the page has no title, like upstream).
          const SliverAppBar(
            floating: true,
            actions: [LanguageButton()],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'about.app_name'.tr(),
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Center(
                    child: Text(
                      'about.subtitle'.tr(),
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  _buildSectionTitle(
                      context, 'about.version'.tr(namedArgs: {'version': '1.2.1'})),
                  const SizedBox(height: 8.0),
                  _buildSectionContent(context,
                      'about.developed_by'.tr(namedArgs: {'name': 'sapatevaibhav'})),
                  const SizedBox(height: 16.0),
                  _buildSectionTitle(context, 'about.purpose_title'.tr()),
                  const SizedBox(height: 8.0),
                  _buildSectionContent(
                    context,
                    'about.purpose'.tr(),
                  ),
                  const SizedBox(height: 16.0),
                  _buildSectionTitle(context, 'about.features_title'.tr()),
                  const SizedBox(height: 8.0),
                  _buildFeature(
                    context,
                    'about.f_atoz'.tr(),
                    'about.f_atoz_desc'.tr(),
                  ),
                  _buildFeature(
                    context,
                    'about.f_animals'.tr(),
                    'about.f_animals_desc'.tr(),
                  ),
                  _buildFeature(
                    context,
                    'about.f_body'.tr(),
                    'about.f_body_desc'.tr(),
                  ),
                  _buildFeature(
                    context,
                    'about.f_birds'.tr(),
                    'about.f_birds_desc'.tr(),
                  ),
                  _buildFeature(
                    context,
                    'about.f_solar'.tr(),
                    'about.f_solar_desc'.tr(),
                  ),
                  _buildFeature(
                    context,
                    'about.f_shapes'.tr(),
                    'about.f_shapes_desc'.tr(),
                  ),
                  const SizedBox(height: 16.0),
                  _buildSectionTitle(context, 'about.source_code'.tr()),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () {
                      _launchURL(
                          context, "https://github.com/VaibhavCodeClub/learn");
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/git.svg',
                          width: 32.0,
                          height: 32.0,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'github.com/VaibhavCodeClub/learn',
                          style: TextStyle(
                            fontSize: 16.0,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _buildSectionTitle(context, 'about.connect'.tr()),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      _buildIcon(context, 'https://github.com/sapatevaibhav',
                          'assets/images/github.svg'),
                      const SizedBox(width: 16.0),
                      _buildIcon(context, 'mailto:sapatevaibhav@duck.com',
                          'assets/images/email.svg'),
                      const SizedBox(width: 16.0),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              context, 'https://linkedin.com/in/sapatevaibhav');
                        },
                        child: SvgPicture.asset(
                          'assets/images/linkedin.svg',
                          width: 32.0,
                          height: 32.0,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      _buildIcon(context, 'https://instagram.com/v.d.r.sapate',
                          'assets/images/instagram.svg'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LearnMorePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18.0),
                      ),
                      child: Text('titles.learn_more'.tr()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16.0,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      ),
    );
  }

  Widget _buildFeature(BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context, String url, String assetPath) {
    return GestureDetector(
      onTap: () {
        _launchURL(context, url);
      },
      child: SvgPicture.asset(
        assetPath,
        width: 32.0,
        height: 32.0,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
    );
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      throw 'Could not launch $url';
    }
  }
}

class LearnMorePage extends StatelessWidget {
  const LearnMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'titles.learn_more'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [LanguageButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'about.detailed_title'.tr()),
            const SizedBox(height: 8.0),
            _buildFeature(
              context,
              'about.f_atoz'.tr(),
              'about.d_atoz'.tr(),
            ),
            _buildFeature(
              context,
              'about.f_animals'.tr(),
              'about.d_animals'.tr(),
            ),
            _buildFeature(
              context,
              'about.f_body'.tr(),
              'about.d_body'.tr(),
            ),
            _buildFeature(
              context,
              'about.f_birds'.tr(),
              'about.d_birds'.tr(),
            ),
            _buildFeature(
              context,
              'about.f_solar'.tr(),
              'about.d_solar'.tr(),
            ),
            _buildFeature(
              context,
              'about.f_shapes'.tr(),
              'about.d_shapes'.tr(),
            ),
            const SizedBox(height: 16.0),
            _buildSectionTitle(context, 'about.guide_title'.tr()),
            const SizedBox(height: 8.0),
            _buildSectionContent(
              context,
              'about.guide'.tr(),
            ),
            const SizedBox(height: 16.0),
            _buildSectionTitle(context, 'about.faq_title'.tr()),
            const SizedBox(height: 8.0),
            _buildSectionContent(
              context,
              'about.faq'.tr(),
            ),
            const SizedBox(height: 16.0),
            _buildSectionTitle(context, 'about.feedback_title'.tr()),
            const SizedBox(height: 8.0),
            _buildSectionContent(
              context,
              'about.feedback'.tr(namedArgs: {'email': 'sapatevaibhav@duck.com'}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16.0,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      ),
    );
  }

  Widget _buildFeature(BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ],
      ),
    );
  }
}
