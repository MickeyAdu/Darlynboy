import 'package:flutter/material.dart';
import 'package:mic_fuel/themes/theme_notifier.dart';
import 'package:provider/provider.dart';

import '../themes/colors.dart';
import '../themes/dark_theme.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Keeps the column size to its minimum height
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 21,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4), // Spacing between text and underline
              Container(
                width: 40, // Width of the underline
                height: 3, // Thickness of the underline
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Same color as the text
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    "Dark mode",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                    setState(() {});
                  },
                  icon: themeProvider.getTheme == darkTheme
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}
