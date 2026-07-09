import 'package:hive_flutter/hive_flutter.dart';
import 'package:versea/utils/routes/consts.dart';

class HiveInit {
  void init() async {
    await Hive.initFlutter();

    await Hive.openBox(kBookBox);
    await Hive.openBox(kChapterBox);
  }
}
