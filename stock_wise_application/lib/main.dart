import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_wise_application/app.dart';
import 'package:stock_wise_application/core/security/encryption_service.dart';
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

  // get the cipher once

  final cipher = await EncryptionService.getHiveCipher();

  // then open all boxes

  await Hive.openBox<CategoryModel>('categories', encryptionCipher: cipher);
  await Hive.openBox<LocationModel>('locations', encryptionCipher: cipher);
  await Hive.openBox<HouseholdModel>('household', encryptionCipher: cipher);
  await Hive.openBox<HouseholdMemberModel>(
    'household_members',
    encryptionCipher: cipher,
  );
  await Hive.openBox<ProductModel>('products', encryptionCipher: cipher);
  await Hive.openBox<ShoppingItemModel>('shopping', encryptionCipher: cipher);
  await Hive.openBox<ConsumptionLogModel>(
    'consumption',
    encryptionCipher: cipher,
  );

  // hive database testing
  await testCategories();
  await testLocations();
  await testProducts();
  await testHousehold();

  runApp(const App());
}
