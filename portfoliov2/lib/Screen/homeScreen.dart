import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:portfoliov2/Widget/AnimatedButton.dart';
import 'package:portfoliov2/Widget/ExperienceWidget.dart';
import 'package:portfoliov2/generated/locale_keys.g.dart';
import 'package:portfoliov2/utils/utils.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int currentIndex = 0;
  final themeController = Get.find<ThemeControllerC>();
  final experienceKey = GlobalKey();
  late String idioma;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        themeController.toggleDarkMode();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    idioma = Localizations.localeOf(context).languageCode;
    final yellow = Colors.yellow[700];
    final backColor = Theme.of(context).canvasColor;
    const IconData linkedin_squared = IconData(0xf30c);

    Icon modeNightIcon = Icon(
        themeController.isDarkMode.value ? Icons.mode_night : Icons.light_mode,
        color: themeController.isDarkMode.value
            ? const Color.fromARGB(255, 233, 229, 229)
            : Colors.black);
    return Scaffold(
      backgroundColor: backColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.25, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Scrollable.ensureVisible(
                        experienceKey.currentContext!,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    onHover: (value) {
                      setState(() {
                        currentIndex = value ? 1 : 0;
                      });
                    },
                    child: Text(LocaleKeys.homeScreen_experiencia.tr(),
                        style: TextStyle(
                            color: currentIndex == 1 ? yellow : Colors.blue))),
                SizedBox(width: 15),
                TextButton(
                    onPressed: () {},
                    onHover: (value) {
                      setState(() {
                        currentIndex = value ? 2 : 0;
                      });
                    },
                    child: Text(LocaleKeys.homeScreen_proyectos.tr(),
                        style: TextStyle(
                            color: currentIndex == 2 ? yellow : Colors.blue))),
                SizedBox(width: 15),
                TextButton(
                    onPressed: () {},
                    onHover: (value) {
                      setState(() {
                        currentIndex = value ? 3 : 0;
                      });
                    },
                    child: Text(LocaleKeys.homeScreen_about_me.tr(),
                        style: TextStyle(
                            color: currentIndex == 3 ? yellow : Colors.blue))),
                SizedBox(width: 15),
                TextButton(
                    onPressed: () {},
                    onHover: (value) {
                      setState(() {
                        currentIndex = value ? 4 : 0;
                      });
                    },
                    child: Text(LocaleKeys.homeScreen_contacto.tr(),
                        style: TextStyle(
                            color: currentIndex == 4 ? yellow : Colors.blue))),
                SizedBox(width: 15),
                IconButton(
                    onPressed: () {
                      setState(() {
                        themeController.toggleDarkMode();
                      });
                    },
                    icon: modeNightIcon,
                    iconSize: 30),
              ],
            ),
            SizedBox(height: 60),
            // Header + badge + buttons
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(""),
                ),
                SizedBox(width: 20),
                Animatedbutton(
                  text: LocaleKeys.homeScreen_disponible_trabajar.tr(),
                  url:
                      'https://www.linkedin.com/in/marc-rovira-perell%C3%B3-823424150/',
                ),
                SizedBox(height: 10),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.homeScreen_hey_soy_marc.tr(),
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: LocaleKeys.homeScreen_dam.tr(),
                        style: TextStyle(
                            color: yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      WidgetSpan(
                        child: SizedBox(width: 5),
                      ),
                      TextSpan(
                        text: LocaleKeys.homeScreen_ubicacion.tr(),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall!.color,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.solidAddressCard,
                      ),
                      label: Text(LocaleKeys.homeScreen_contact.tr()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: Colors.yellow),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.linkedin,
                      ),
                      label: Text(LocaleKeys.homeScreen_linkedin.tr()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: Colors.yellow),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                )
              ],
            ),

            SizedBox(height: 80),
            // Experiencia Section
            Container(
              key: experienceKey,
            ),
            Experiencewidget(
              idioma: idioma,
            )
          ],
        ),
      ),
    );
  }
}
