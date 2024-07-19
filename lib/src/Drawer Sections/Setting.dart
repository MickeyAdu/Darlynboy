import 'package:flutter/material.dart';
import 'package:mic_fuel/themes/theme_notifier.dart';
import 'package:provider/provider.dart';

import '../../themes/dark_theme.dart';

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
        title: const Text("Settings"),
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
                    themeProvider.changeTheme();
                    setState(() {});
                  },
                  icon: themeProvider.getTheme == darkTheme
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                )
                // Switch.adaptive(
                //     activeColor: Colors.grey,
                //     value: themeProvider.getTheme == darkTheme,
                //     onChanged: (value) {
                //       themeProvider.changeTheme();
                //     })
              ],
            ),
          ],
        );
      }),
    );
  }
}
