import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/household/data/models/household_member_model.dart';
import 'package:stock_wise_application/features/household/data/models/household_model.dart';

Future<void> testHousehold() async {
  final box = Hive.box<HouseholdModel>('household');
  await box.clear();

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
  await box.put(household.id, household);
  debugPrint(' CREATE → foyer "${household.name}" créé');

  // READ
  final h = box.get('house1')!;
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
    '\n  UPDATE → ${box.get('house1')!.members.length} membres maintenant',
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
