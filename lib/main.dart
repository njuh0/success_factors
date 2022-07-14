import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:success_factors/achievements.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:success_factors/hive/achievement_hive.dart';
import 'package:success_factors/hive/factor_hive.dart';
import 'package:success_factors/provider/hive_provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FactorHiveAdapter());
  Hive.registerAdapter(AchievementHiveAdapter());

  // var box = await Hive.openBox<AchievementHive>('achi');
  // box.clear();

  // print(box.values.toString());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HiveProvider(),
        ),
        ChangeNotifierProvider<HiveProvider>(create: (_) => HiveProvider()),
      ],
      child: Builder(builder: (context) {
        return FutureBuilder(
          future: context.read<HiveProvider>().initAchi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) return const Main();
            return Container();
          },
        );
      }),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  static const Map<int, Color> color = {
    50: Color.fromRGBO(232, 189, 249, .1),
    100: Color.fromRGBO(232, 189, 249, .2),
    200: Color.fromRGBO(232, 189, 249, .3),
    300: Color.fromRGBO(232, 189, 249, .4),
    400: Color.fromRGBO(232, 189, 249, .5),
    500: Color.fromRGBO(232, 189, 249, .6),
    600: Color.fromRGBO(232, 189, 249, .7),
    700: Color.fromRGBO(232, 189, 249, .8),
    800: Color.fromRGBO(232, 189, 249, .9),
    900: Color.fromRGBO(232, 189, 249, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Success Factors',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: text1,
          ),
        ),
        fontFamily: 'Kanit',
        primarySwatch: const MaterialColor(0xFF191923, color),
      ),
      home: const Achievements(title: 'ACHIEVEMENTS'),
    );
  }
}
