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
          child: Row(
            children: [
              // Imagen de fondo a la izquierda
              Expanded(
                flex: 2,
                child: Image.asset(
                  'assets/img/background_card.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),

              // Card con info a la derecha
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 32.0),
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
                        const Text(
                          "Marc Rovira Perelló",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          LocaleKeys.PresentationDialog_dam.tr(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton.icon(
                          onPressed: () {
                            _launchPhone();
                          },
                          icon: const Icon(Icons.phone, size: 20),
                          label: Text(LocaleKeys.PresentationDialog_phone.tr()),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            _launchEmail();
                          },
                          icon: const Icon(Icons.mail_outline, size: 20),
                          label: Text(LocaleKeys.PresentationDialog_mail.tr()),
                        ),
                      ],
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
