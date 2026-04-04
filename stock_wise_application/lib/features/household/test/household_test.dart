import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/household/data/models/household_member_model.dart';
import 'package:stock_wise_application/features/household/data/models/household_model.dart';
import 'package:stock_wise_application/features/household/data/repositories/household_repository_implementation.dart';
import 'package:stock_wise_application/features/household/useCases/delete_household.dart';
import 'package:stock_wise_application/features/household/useCases/get_households.dart';
import 'package:stock_wise_application/features/household/useCases/reset_household.dart';
import 'package:stock_wise_application/features/household/useCases/save_household.dart';

Future<void> testHousehold() async {
  final repository = HouseholdRepositoryImplementation(
    Hive.box<HouseholdModel>('household'),
  );

  final resetHousehold = ResetHousehold(repository);
  final saveHousehold = SaveHousehold(repository);
  final getHouseholds = GetHouseholds(repository);
  final deleteHousehold = DeleteHousehold(repository);

  await resetHousehold.call();

  debugPrint('\n========== HOUSEHOLD ==========');

  final household = HouseholdModel(
    id: 'house1',
    name: 'Famille Rakoto',
    members: [
      HouseholdMemberModel(id: 'mem1', name: 'Papa', role: 'admin'),
      HouseholdMemberModel(id: 'mem2', name: 'Maman', role: 'admin'),
      HouseholdMemberModel(id: 'mem3', name: 'Fils', role: 'member'),
    ],
  );
  await saveHousehold.call(household);
  debugPrint(' CREATE → foyer "${household.name}" créé');

  // READ
  final h = getHouseholds.call().first;
  debugPrint('\n READ foyer :');
  debugPrint('   Nom : ${h.name}');
  debugPrint('   Membres (${h.members.length}) :');
  for (final m in h.members) {
    debugPrint('     - ${m.name} [${m.role}]');
  }

  // UPDATE — ajouter un membre
  h.members.add(
    HouseholdMemberModel(id: 'mem4', name: 'Fille', role: 'member'),
  );
  await h.save();
  debugPrint(
    '\n UPDATE → ${getHouseholds.call().first.members.length} membres maintenant',
  );

  // DELETE
  await deleteHousehold.call('house1');
  debugPrint(' DELETE → ${getHouseholds.call().length} foyers restants');

  // RESET
  await resetHousehold.call();
  debugPrint(
    ' RESET → ${getHouseholds.call().length} foyers après réinitialisation',
  );
}

// ━━━ APP VIDE (juste pour lancer) ━━━━━━━━━━
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Check la console !'))),
    );
  }
}
