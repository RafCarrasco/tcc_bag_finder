import 'package:tcc_bag_finder/app/app_module.dart';
import 'package:tcc_bag_finder/app/app_widget.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/adapters.dart';

late Box userStorage;

late Box bagStorage;

late Box tripStorage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  userStorage = await Hive.openBox<UserEntity>(
    'userStorage',
  );
  bagStorage = await Hive.openBox<BagEntity>(
    'bagStorage',
  );
  tripStorage = await Hive.openBox<TripEntity>(
    'tripStorage',
  );

  return runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
