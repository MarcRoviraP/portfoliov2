import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfoliov2/class/Experiece.dart';
import 'package:portfoliov2/generated/locale_keys.g.dart';

class Experiencewidget extends StatefulWidget {
  final String idioma;

  const Experiencewidget({super.key, required this.idioma});

  @override
  State<Experiencewidget> createState() => _ExperiencewidgetState();
}

class _ExperiencewidgetState extends State<Experiencewidget> {
  List<Experiencia> experienciasFuture = [];

  Future<void> cargarExperiencias() async {
    try {
      final String response = await rootBundle
          .loadString("assets/data/experiencia_${widget.idioma}.json");
      final data = json.decode(response);

      final List experienciasJson = data['experiencia'];
      experienciasFuture = experienciasJson
          .map((e) => Experiencia.fromJson(e))
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
      future: cargarExperiencias(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else {
          return Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.work_outline,
                      color: Colors.yellow, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    LocaleKeys.homeScreen_experiencia.tr(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: experienciasFuture
                    .map(
                      (exp) => _timelineItem(
                        exp.funcion,
                        exp.lugar,
                        exp.descripcion,
                        date: exp.fecha,
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

  Widget _timelineItem(
    String title,
    String subtitle,
    String description, {
    String? date,
  }) {
    Color dotColor = Colors.yellow;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 120,
              color: dotColor,
            )
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                      TextStyle(color: dotColor, fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              if (date != null)
                Text(date, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              Text(description,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall!.color)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
