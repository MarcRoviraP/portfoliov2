import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfoliov2/class/Proyecto.dart';
import 'package:portfoliov2/generated/locale_keys.g.dart';
import 'package:portfoliov2/utils/utils.dart';

class ProyectWidget extends StatefulWidget {
  final String idioma;

  const ProyectWidget({super.key, required this.idioma});

  @override
  State<ProyectWidget> createState() => _ProyectWidgetState();
}

class _ProyectWidgetState extends State<ProyectWidget> {
  List<Proyecto> futureProjects = [];

  Future<void> cargarProyectos() async {
    try {
      final String response = await rootBundle
          .loadString("assets/data/proyecto_${widget.idioma}.json");
      final data = json.decode(response);

      final List projectsJson = data['proyecto'];
      futureProjects = projectsJson
          .map((e) => Proyecto.fromJson(e))
          .toList()
          .reversed
          .toList();
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cargarProyectos(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else {
          return Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.code, color: Colors.yellow, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    LocaleKeys.Proyectwidget_project.tr(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: futureProjects
                    .map(
                      (exp) => _buildProject(
                        exp.imagen,
                        exp.titulo,
                        exp.descripcion,
                        exp.link,
                      ),
                    )
                    .toList(),
              )
            ],
          );
        }
      },
    );
  }

  Widget _buildProject(
    String img,
    String title,
    String description,
    String link,
  ) {
    Color dotColor = Colors.yellow;
    bool isHovered = false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 600;

              return StatefulBuilder(
                builder: (context, setInnerState) {
                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      MouseRegion(
                        onEnter: (_) => setInnerState(() => isHovered = true),
                        onExit: (_) => setInnerState(() => isHovered = false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: isWide ? (isHovered ? 520 : 400) : 200,
                          height: isWide ? (isHovered ? 520 : 400) : 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage('assets/img/$img'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: isWide ? 500 : double.infinity),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              description,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                if (link.isNotEmpty) {
                                  newDeployURL(link);
                                }
                              },
                              icon:
                                  const Icon(FontAwesomeIcons.github, size: 16),
                              label: const Text('GitHub'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
