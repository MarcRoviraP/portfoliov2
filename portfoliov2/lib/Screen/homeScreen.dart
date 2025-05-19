import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
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
    final yellow = Colors.yellow[700];
    final backColor = Theme.of(context).canvasColor;
    Icon mode_night = Icon(
        themeController.isDarkMode.value ? Icons.mode_night : Icons.light_mode,
        color: themeController.isDarkMode.value ? Colors.white : Colors.black);
    return Scaffold(
      backgroundColor: backColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
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
                    icon: mode_night,
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
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?img=12'),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: yellow!),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Disponible para trabajar',
                          style: TextStyle(color: yellow, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Hey, soy Marc',
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
                              text:
                                  'Desarrollador de Aplicaciones Multiplataforma ',
                              style: TextStyle(
                                  color: yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            TextSpan(
                              text: 'de Valencia, España es.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.mail_outline),
                            label: Text('Contáctame'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: BorderSide(color: yellow),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          SizedBox(width: 15),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons
                                .linked_camera), // icono aproximado, usa icono LinkedIn si tienes
                            label: Text('LinkedIn'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: BorderSide(color: yellow),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 80),
            // Experiencia Section
            Row(
              children: [
                Icon(Icons.work_outline, color: yellow, size: 28),
                SizedBox(width: 8),
                Text(
                  'Experiencia',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Timeline experience entries
            Column(
              children: [
                _timelineItem(
                  yellow,
                  'Estudiante de DAM',
                  'IES Sant Vicent Ferrer',
                  'Actualmente estudio DAM en el IES Sant Vicent Ferrer de Algemesí.',
                ),
                SizedBox(height: 30),
                _timelineItem(
                  yellow,
                  'Tecnico de sistemas',
                  'Microsoft',
                  'Reparación de equipos (ordenadores, impresoras, etc) y técnico de redes.',
                  date: 'Marzo 2023',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _timelineItem(
      Color? dotColor, String title, String subtitle, String description,
      {String? date}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dot and line
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration:
                  BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
            Container(
              width: 2,
              height: 120,
              color: dotColor,
            )
          ],
        ),
        SizedBox(width: 20),
        // Text content left
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                      TextStyle(color: dotColor, fontWeight: FontWeight.bold)),
              Text(subtitle, style: TextStyle(fontWeight: FontWeight.bold)),
              if (date != null) Text(date, style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        // Description right
        Expanded(
          flex: 5,
          child: Text(
            description,
          ),
        )
      ],
    );
  }
}
