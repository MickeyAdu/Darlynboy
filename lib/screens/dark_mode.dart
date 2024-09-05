import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/themes/style.dart';
import 'package:mic_fuel/themes/theme_notifier.dart';
import 'package:provider/provider.dart';

import '../themes/colors.dart';
import '../themes/dark_theme.dart';

class DarkMode extends StatefulWidget {
  const DarkMode({super.key});

  @override
  State<DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    var titleStyle = textTheme.titleLarge
        ?.copyWith(color: Theme.of(context).colorScheme.primary);
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 25.sp,
            )),
        title: Text(
          "Toggle Modes",
          style: textTheme.bodyLarge!.copyWith(fontSize: 22),
        ),
      ),
      body: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Dark Mode",
                    style: textTheme.bodyLarge!.copyWith(fontSize: 22),
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
