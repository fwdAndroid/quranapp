import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quranapp/provider/language_provider.dart';

class ChangeLangage extends StatefulWidget {
  const ChangeLangage({super.key});

  @override
  State<ChangeLangage> createState() => _ChangeLangageState();
}

class _ChangeLangageState extends State<ChangeLangage> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(
      context,
    ); // Access the provider

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          languageProvider.localizedStrings['Language'] ?? "Language",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 16),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  languageProvider.localizedStrings['Select Language'] ??
                      'Select Language',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            // ListTile for Arabic
            ListTile(
              onTap: () {
                languageProvider.changeLanguage('ar'); // Change to Spanish
                Navigator.pop(context); // Optionally close the language screen
              },
              trailing: Icon(
                languageProvider.currentLanguage == 'ar'
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: Colors.black,
                size: 20,
              ),
              title: Text(
                languageProvider.localizedStrings['Arabic'] ?? "Arabic",
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
              ),
            ),
            // ListTile for English
            ListTile(
              onTap: () {
                languageProvider.changeLanguage('en'); // Change to English
                Navigator.pop(context);
              },
              trailing: Icon(
                languageProvider.currentLanguage == 'en'
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: Colors.black,
                size: 20,
              ),
              title: Text(
                languageProvider.localizedStrings['English'] ?? "English",
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
              ),
            ),

            // ListTile for French
          ],
        ),
      ),
    );
  }
}
