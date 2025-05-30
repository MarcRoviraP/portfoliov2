import 'package:portfoliov2/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PresentationDialog extends StatefulWidget {
  const PresentationDialog({super.key});

  @override
  State<PresentationDialog> createState() => _PresentationDialogState();
}

class _PresentationDialogState extends State<PresentationDialog> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.7;
    final containerHeight = containerWidth * 9 / 16;

    return Center(
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Imagen de fondo (alineada a la izquierda)
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: containerWidth,
                  height: containerHeight,
                  child: Image.asset(
                    'assets/img/background_card.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Card con info (alineada a la derecha)
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: containerWidth * 0.7, // Ancho del contenedor de texto
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withAlpha(230),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Marc Rovira Perelló",
                            style: TextStyle(
                              fontSize: containerWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: containerWidth * 0.01),
                          Text(
                            LocaleKeys.PresentationDialog_dam.tr(),
                            style: TextStyle(
                              fontSize: containerWidth * 0.04,
                            ),
                          ),
                          SizedBox(height: containerWidth * 0.01),
                          TextButton.icon(
                            onPressed: () {
                              _launchPhone();
                            },
                            icon:
                                Icon(Icons.phone, size: containerWidth * 0.03),
                            label: Text(
                              LocaleKeys.PresentationDialog_phone.tr(),
                              style: TextStyle(
                                fontSize: containerWidth * 0.03,
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              _launchEmail();
                            },
                            icon: Icon(Icons.mail_outline,
                                size: containerWidth * 0.03),
                            label: Text(
                              LocaleKeys.PresentationDialog_mail.tr(),
                              style: TextStyle(
                                fontSize: containerWidth * 0.03,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+34645029216');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      debugPrint('No se pudo lanzar el teléfono');
    }
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'treballsrovireta@gmail.com',
      query: 'subject=Hola Marc&body=Me interesa tu perfil 👀',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint('No se pudo lanzar el correo');
    }
  }
}
