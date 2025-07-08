import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfoliov2/utils/utils.dart';

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
  late bool _hovering;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _hovering = false;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  LinearGradient _getDynamicGradient() {
    final blueShade = 100 + _random.nextInt(155);
    return LinearGradient(
      colors: [
        Color.fromARGB(255, 30, 144, blueShade),
        Color.fromARGB(255, 0, 80, 255),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseShadowColor = Colors.blueAccent.withOpacity(0.6);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => newDeployURL(widget.url),
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            final scale = _hovering ? _pulseAnimation.value : 1.0;

            return Transform.scale(
              scale: scale,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: _getDynamicGradient(),
                  boxShadow: [
                    BoxShadow(
                      color: baseShadowColor,
                      blurRadius: _hovering ? 20 : 10,
                      spreadRadius: _hovering ? 2 : 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.2,
                  ),
                  color: Colors.white.withOpacity(0.1),
                  backgroundBlendMode: BlendMode.overlay,
                ),
                child: Text(
                  widget.text.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
