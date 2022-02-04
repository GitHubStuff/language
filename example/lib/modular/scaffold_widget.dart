import 'package:extensions_package/extensions_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rae_localization_package/rae_localization_package.dart';
import 'package:theme_management/theme_management.dart';

/// Rotates through the localization enums
class LocalizationInformation {
  static List<Type> types = [
    RAELocalization,
    EmotionLocalization,
    Greeting,
    GarminLocalization,
    LevelOfSymptomLocalization,
  ];
  LocalizationInformation({required BuildContext context, int? enumIndex}) {
    final dynamic localizationIdentifier = LocalizationInformation.types[LocalizationInformation.localizationIndex];
    String key = '';
    String value = '';
    int index = enumIndex ?? 0;
    switch (localizationIdentifier) {
      case RAELocalization:
        length = RAELocalization.values.length;
        key = RAELocalization.values[index].name;
        value = RAELocalization.values[index].text;
        break;
      case EmotionLocalization:
        length = EmotionLocalization.values.length;
        key = EmotionLocalization.values[index].name;
        value = EmotionLocalization.values[index].text;
        break;
      case Greeting:
        length = Greeting.values.length;
        key = Greeting.values[index].name;
        value = Greeting.values[index].text;
        break;
      case GarminLocalization:
        length = GarminLocalization.values.length;
        key = GarminLocalization.values[index].name;
        value = GarminLocalization.values[index].text;
        break;
      case LevelOfSymptomLocalization:
        length = LevelOfSymptomLocalization.values.length;
        key = LevelOfSymptomLocalization.values[index].name;
        value = LevelOfSymptomLocalization.values[index].text;
        break;
      default:
        throw FlutterError('Unknown localizationIdentifier ${localizationIdentifier.toString()}');
    }
    listTile = Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: ListTile(
          title: Text(key).fontSize(20),
          subtitle: Text(value).fontSize(16),
        ),
      )
          .background(ThemeColors(
            dark: Colors.black87,
            light: Colors.yellow.shade50,
          ).of(context))
          .borderAll(Colors.green),
    );
  }

  ///
  late int length;
  late Widget listTile;

  ///
  static Widget at({required int index, required BuildContext context}) => LocalizationInformation(
        context: context,
        enumIndex: index,
      ).listTile;
  static int localizationIndex = 0;

  static Text buttonText() => Text(types[localizationIndex].toString()).fontSize(18.0);

  static void next() => localizationIndex = (localizationIndex + 1) == types.length ? 0 : ++localizationIndex;
}

///
class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScaffoldWidget createState() => _ScaffoldWidget();
}

class _ScaffoldWidget extends ObservingStatefulWidget<ScaffoldWidget> with ThemeMixin, DialogMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [],
        ),
        body: rebuildTreeOnThemeOrCubit<RAELanguageState>(bodyWidget: _body, cubit: RAELanguage.cubit),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showWidgetInDialog(
              context,
              child: Text('Does Nothing').fontSize(46.0),
              displayDuration: Duration(seconds: 2),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );

  Widget _body(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(Greeting.helloWorld.text).fontSize(22.0), //Example of localization
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 3.0,
                  children: [
                    ElevatedButton(onPressed: () => RAELanguage.locale = Locale('en'), child: Text('English')),
                    ElevatedButton(onPressed: () => RAELanguage.locale = Locale('es'), child: Text('Spanish')),
                    ElevatedButton(onPressed: () => RAELanguage.locale = Locale('de'), child: Text('German')),
                    ElevatedButton(onPressed: () => RAELanguage.locale = Locale('ko'), child: Text('Korean')),
                  ],
                ),
              ),
            ],
          ),
        ).borderAll(Colors.blueAccent).paddingAll(3.0),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                BlocBuilder<ThemeModeCubit, ThemeModeState>(
                    bloc: ThemeManagement.themeModeCubit,
                    builder: (_, state) {
                      return Text(
                        'ThemeMode: ${ThemeManagement.themeMode.brightnessMode(context).name}',
                      ).fontSize(TextKey.headline6.fontSize);
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () => ThemeManagement.themeMode = ThemeMode.dark, child: Text('Dark')),
                    ElevatedButton(onPressed: () => ThemeManagement.themeMode = ThemeMode.light, child: Text('Light')),
                    ElevatedButton(onPressed: () => ThemeManagement.themeMode = ThemeMode.system, child: Text('System')),
                  ],
                ),
                _themeIcons(),
              ],
            ),
          ),
        )
            .borderAll(
              ThemeColors(
                dark: Colors.amber,
                light: Colors.black87,
              ).of(context),
            )
            .paddingAll(3.0),
        SizedBox(height: 4),
        ElevatedButton(
            onPressed: () {
              setState(() {
                LocalizationInformation.next();
              });
            },
            child: LocalizationInformation.buttonText()),
        Expanded(
          flex: 2,
          child: ListView.builder(
            itemCount: LocalizationInformation(context: context).length,
            itemBuilder: (context, index) => LocalizationInformation.at(index: index, context: context),
          ),
        ),
        SizedBox(height: 72.0),
      ],
    );
  }

  Widget _themeIcons() {
    return Column(
      children: [
        Row(
          children: [
            BrightnessType.appDark.icon(context).padding(left: 8, right: 6, bottom: 2),
            Text(BrightnessType.appDark.name),
            BrightnessType.appLight.icon(context).padding(left: 8, right: 6, bottom: 2),
            Text(BrightnessType.appLight.name),
          ],
        ),
        Row(
          children: [
            BrightnessType.systemDark.icon(context).padding(left: 8, right: 6, bottom: 2),
            Text(BrightnessType.systemDark.name),
            BrightnessType.systemLight.icon(context).padding(left: 8, right: 6, bottom: 2),
            Text(BrightnessType.systemLight.name),
          ],
        ),
      ],
    );
  }
}
