import 'package:device_preview/device_preview.dart';
import 'package:device_preview/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

class BasicApp extends StatelessWidget {
  const BasicApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text('Basic'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ...Iterable.generate(
            15,
            (i) => ListTile(
              title: Text(AppLocalizations.of(context)!.tile(i)),
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
