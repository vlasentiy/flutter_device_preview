import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/state/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'section.dart';

/// All the simulated system settings.
class SystemSection extends StatelessWidget {
  /// Create a new menu section with simulated systel properties.
  ///
  /// The items can be hidden with [locale], [theme] parameters.
  const SystemSection({
    Key? key,
    this.locale = true,
    this.theme = true,
  }) : super(key: key);

  /// Allow to select the current device locale.
  final bool locale;

  /// Allow to override the current system theme (dark/light)
  final bool theme;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
      (DevicePreviewStore store) => store.data.isDarkMode,
    );

    final locales = context.select(
      (DevicePreviewStore store) => store.locales,
    );

    final selectedLocale = locales.firstWhere(
      (element) =>
          element.code ==
          context.select(
            (DevicePreviewStore store) => store.data.locale,
          ),
      orElse: () => locales.first,
    );

    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.grey.withValues(alpha: 0.2),
        highlightColor: Colors.grey.withValues(alpha: 0.2),
      ),
      child: ToolPanelSection(
        title: 'System',
        children: [
          if (locale)
            ListTile(
              key: const Key('locale'),
              title: const Text('Locale'),
              subtitle: Text(selectedLocale.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ((selectedLocale.code == 'en') ? '🇬🇧' : '🇺🇦'),
                    style: const TextStyle(fontSize: 36),
                  )
                ],
              ),
              onTap: () {
                final newLocaleCode = selectedLocale.code == 'en' ? 'uk' : 'en';
                final store = context.read<DevicePreviewStore>();
                store.data = store.data.copyWith(locale: newLocaleCode);
                final devicePreview =
                    context.findAncestorWidgetOfExactType<DevicePreview>();
                devicePreview?.onChangeLanguageToggle?.call(newLocaleCode);
              },
            ),
          if (theme)
            ListTile(
              key: const Key('theme'),
              title: const Text('Theme'),
              subtitle: Text(isDarkMode ? 'Dark' : 'Light'),
              trailing: Text(
                (isDarkMode ? '🌚' : '🌝'),
                style: const TextStyle(fontSize: 36),
              ),
              onTap: () {
                final state = context.read<DevicePreviewStore>();
                state.toggleDarkMode();

                final devicePreview =
                    context.findAncestorWidgetOfExactType<DevicePreview>();
                devicePreview?.onDarkThemeToggle?.call(!isDarkMode);
              },
            ),
        ],
      ),
    );
  }
}
