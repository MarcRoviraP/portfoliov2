import 'dart:html' as html;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfoliov2/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class Animatedbutton extends StatefulWidget {
  final String text;
  final String url;

  const Animatedbutton({super.key, required this.text, required this.url});

  @override
  State<Animatedbutton> createState() => _AnimatedbuttonState();
}

class _AnimatedbuttonState extends State<Animatedbutton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  Color baseColor = const Color.fromARGB(255, 48, 119, 226);

  @override
  void initState() {
    super.initState();

    // Controlador del efecto de latido
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
          // Opcional: cambia de color base en cada pulso
          baseColor = _getRandomColor();
        }
      });

    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      128, // Opacidad total
      0, // Rojo = 0 para eliminar tonos cálidos
      random.nextInt(20), // Verde
      100 + random.nextInt(156), // Azul
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        newDeployURL(widget.url);
      },
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          // Modifica la opacidad (intensidad) del borde
          final color = baseColor.withOpacity(_pulseAnimation.value);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color, width: 2),
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            ),
            child: Text(
              widget.text,
            ),
          );
        },
      ),
    );
  }
}
