import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfoliov2/generated/locale_keys.g.dart';

class Aboutme extends StatefulWidget {
  const Aboutme({super.key});

  @override
  State<Aboutme> createState() => _AboutmeState();
}

class _AboutmeState extends State<Aboutme> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        runSpacing: 20,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(FontAwesomeIcons.userAstronaut,
                      color: Colors.yellow, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    LocaleKeys.homeScreen_about_me.tr(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          LocaleKeys.AboutMe_about_me_text.tr(),
                          style: const TextStyle(fontSize: 16, height: 1.5),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          LocaleKeys.AboutMe_about_me_text2.tr(),
                          style: const TextStyle(fontSize: 16, height: 1.5),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20, height: 20),
                  Flexible(
                    flex: 1,
                    child: ImagenTiltedCard(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImagenTiltedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double imageSize = width > 600 ? 200 : 150;

    return Center(
      child: Transform.rotate(
        angle: -0.05,
        child: Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.white24,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/img/me.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
