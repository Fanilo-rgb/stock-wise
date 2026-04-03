import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_wise_application/app.dart';
import 'package:stock_wise_application/features/category/data/models/category_model.dart';
import 'package:stock_wise_application/features/category/test/category_test.dart';
import 'package:stock_wise_application/features/consumption/data/models/consumption_log_model.dart';
import 'package:stock_wise_application/features/household/data/models/household_member_model.dart';
import 'package:stock_wise_application/features/household/data/models/household_model.dart';
import 'package:stock_wise_application/features/household/test/household_test.dart';
import 'package:stock_wise_application/features/location/data/models/location_model.dart';
import 'package:stock_wise_application/features/location/test/location_test.dart';
import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/test/product_test.dart';
import 'package:stock_wise_application/features/shopping/data/models/shopping_item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // save all the Adapters

  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ConsumptionLogModelAdapter());
  Hive.registerAdapter(HouseholdMemberModelAdapter());
  Hive.registerAdapter(HouseholdModelAdapter());
  Hive.registerAdapter(LocationModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(ShoppingItemModelAdapter());

  // open all boxes

  await Hive.openBox<CategoryModel>('categories');
  await Hive.openBox<LocationModel>('locations');
  await Hive.openBox<HouseholdModel>('household');
  await Hive.openBox<HouseholdMemberModel>('household_members');
  await Hive.openBox<ProductModel>('products');
  await Hive.openBox<ShoppingItemModel>('shopping');
  await Hive.openBox<ConsumptionLogModel>('consumption');

  // hive database testing
  await testCategories();
  await testLocations();
  await testProducts();
  await testHousehold();

  runApp(const App());
}
