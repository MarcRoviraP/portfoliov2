import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfoliov2/Dialog/PresentationDialog.dart';
import 'package:portfoliov2/Widget/AboutMe.dart';
import 'package:portfoliov2/Widget/AnimatedButton.dart';
import 'package:portfoliov2/Widget/ExperienceWidget.dart';
import 'package:portfoliov2/Widget/Proyectwidget.dart';
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
  final projectsKey = GlobalKey();
  final aboutMeKey = GlobalKey();

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

    return Scaffold(
      backgroundColor: backColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveAppBar(
              currentIndex: currentIndex,
              onTap: (index) {
                if (index == 99) {
                  setState(() => themeController.toggleDarkMode());
                  return;
                }

                setState(() => currentIndex = index);

                final sectionKey = [
                  experienceKey,
                  projectsKey,
                  aboutMeKey,
                ][index];

                if (sectionKey.currentContext != null) {
                  Scrollable.ensureVisible(
                    sectionKey.currentContext!,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              onThemeToggle: () {
                setState(() => themeController.toggleDarkMode());
              },
              isDarkMode: themeController.isDarkMode.value,
            ),
            const SizedBox(height: 60),
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: Image.asset('assets/img/marc.png').image,
                    ),
                    Animatedbutton(
                      text: StringTranslateExtension(
                              LocaleKeys.homeScreen_disponible_trabajar)
                          .tr(),
                      url:
                          'https://www.linkedin.com/in/marc-rovira-perell%C3%B3-823424150/',
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringTranslateExtension(LocaleKeys.homeScreen_hey_soy_marc)
                      .tr(),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            StringTranslateExtension(LocaleKeys.homeScreen_dam)
                                .tr(),
                        style: TextStyle(
                            color: yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 5),
                      ),
                      TextSpan(
                        text: StringTranslateExtension(
                                LocaleKeys.homeScreen_ubicacion)
                            .tr(),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall!.color,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
  context: context,
  builder: (_) => const Dialog(
    backgroundColor: Colors.transparent,
    insetPadding: EdgeInsets.all(20),
    child: PresentationDialog(),
  ),
);

                      },
                      icon: const Icon(FontAwesomeIcons.solidAddressCard),
                      label: Text(StringTranslateExtension(
                              LocaleKeys.homeScreen_contact)
                          .tr()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Colors.yellow),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        newDeployURL(
                            "https://www.linkedin.com/in/marc-rovira-perell%C3%B3-823424150/");
                      },
                      icon: const Icon(FontAwesomeIcons.linkedin),
                      label: Text(StringTranslateExtension(
                              LocaleKeys.homeScreen_linkedin)
                          .tr()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Colors.yellow),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 80),
            Container(key: experienceKey),
            Experiencewidget(idioma: idioma),
            const SizedBox(height: 80),
            Container(key: projectsKey),
            ProyectWidget(idioma: idioma),
            const SizedBox(height: 80),
            Container(key: aboutMeKey),
            Aboutme()
          ],
        ),
      ),
    );
  }
}

class ResponsiveAppBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const ResponsiveAppBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<ResponsiveAppBar> createState() => _ResponsiveAppBarState();
}

class _ResponsiveAppBarState extends State<ResponsiveAppBar> {
  int index = -1;
  @override
  Widget build(BuildContext context) {
    final yellow = Colors.yellow[700];
    final items = [
      StringTranslateExtension(LocaleKeys.homeScreen_experiencia).tr(),
      StringTranslateExtension(LocaleKeys.homeScreen_proyectos).tr(),
      StringTranslateExtension(LocaleKeys.homeScreen_about_me).tr(),
      StringTranslateExtension(LocaleKeys.homeScreen_contacto).tr(),
    ];

    if (MediaQuery.of(context).size.width > 800) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                onHover: (value) {
                  setState(() {
                    index = value ? i : -1;
                  });
                },
                onPressed: () => widget.onTap(i),
                child: Text(
                  items[i],
                  style: TextStyle(
                    color: index == i ? yellow : Colors.blue,
                  ),
                ),
              ),
            ),
          IconButton(
            onPressed: widget.onThemeToggle,
            icon: Icon(widget.isDarkMode ? Icons.mode_night : Icons.light_mode),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Marc Rovira', style: Theme.of(context).textTheme.titleLarge),
          PopupMenuButton<int>(
            onSelected: widget.onTap,
            itemBuilder: (context) => [
              for (int i = 0; i < items.length; i++)
                PopupMenuItem<int>(value: i, child: Text(items[i])),
              const PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 99,
                child: Row(
                  children: [
                    Icon(widget.isDarkMode
                        ? Icons.light_mode
                        : Icons.mode_night),
                    const SizedBox(width: 8),
                    Text(StringTranslateExtension(LocaleKeys.homeScreen_Tema)
                        .tr()),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}
