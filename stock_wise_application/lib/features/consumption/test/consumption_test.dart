import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/consumption/data/models/consumption_log_model.dart';
import 'package:stock_wise_application/features/consumption/data/repositories/consumption_repository_implementation.dart';
import 'package:stock_wise_application/features/consumption/useCases/delete_consumption_log.dart';
import 'package:stock_wise_application/features/consumption/useCases/get_consumption_logs.dart';
import 'package:stock_wise_application/features/consumption/useCases/reset_consumption_log.dart';
import 'package:stock_wise_application/features/consumption/useCases/save_consumption_log.dart';

Future<void> testConsumption() async {
  final repository = ConsumptionRepositoryImplementation(
    Hive.box<ConsumptionLogModel>('consumption'),
  );

  final resetConsumption = ResetConsumptionLog(repository);
  final saveConsumption = SaveConsumptionLog(repository);
  final getConsumptionLogs = GetConsumptionLogs(repository);
  final deleteConsumption = DeleteConsumptionLog(repository);

  await resetConsumption.call();

  debugPrint('\n========== CONSUMPTION ==========');

  // CREATE
  final logs = [
    ConsumptionLogModel(
      id: 'con1',
      productId: 'prod1',
      productName: 'Riz',
      quantityUsed: 2.5,
      date: DateTime(2026, 4, 1),
      cost: 5.0,
    ),
    ConsumptionLogModel(
      id: 'con2',
      productId: 'prod2',
      productName: 'Beurre',
      quantityUsed: 0.5,
      date: DateTime(2026, 4, 2),
      cost: 3.0,
    ),
    ConsumptionLogModel(
      id: 'con3',
      productId: 'prod3',
      productName: 'Sucre',
      quantityUsed: 1.0,
      date: DateTime(2026, 4, 3),
      cost: 1.5,
    ),
  ];
  for (final log in logs) {
    await saveConsumption.call(log);
  }
  debugPrint(
    ' CREATE → ${getConsumptionLogs.call().length} logs de consommation ajoutés',
  );

  // READ
  debugPrint('\n READ consommation :');
  for (final log in getConsumptionLogs.call()) {
    debugPrint('   - ${log.productName} : ${log.quantityUsed}');
  }

  // DELETE
  await deleteConsumption.call('con1');
  debugPrint('\n DELETE → ${getConsumptionLogs.call().length} logs restants');

  // RESET
  await resetConsumption.call();
  debugPrint(
    ' RESET → ${getConsumptionLogs.call().length} logs après réinitialisation',
  );
}
