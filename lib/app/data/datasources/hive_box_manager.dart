import 'package:hive/hive.dart';

class HiveBoxManager {
  static Future<Box<T>> getBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }
}
