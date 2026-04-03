import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/location/data/models/location_model.dart';

Future<void> testLocations() async {
  final box = Hive.box<LocationModel>('locations');
  await box.clear();

  debugPrint('\n========== LOCATIONS ==========');

  // CREATE parents
  final cuisine = LocationModel(id: 'loc1', name: 'Cuisine');
  final sdb = LocationModel(id: 'loc2', name: 'Salle de bain');
  await box.put(cuisine.id, cuisine);
  await box.put(sdb.id, sdb);

  // CREATE enfants
  final frigo = LocationModel(id: 'loc3', name: 'Frigo', parentId: 'loc1');
  final placard = LocationModel(id: 'loc4', name: 'Placard', parentId: 'loc1');
  final armoire = LocationModel(id: 'loc5', name: 'Armoire', parentId: 'loc2');
  await box.put(frigo.id, frigo);
  await box.put(placard.id, placard);
  await box.put(armoire.id, armoire);

  debugPrint('CREATE → ${box.length} locations ajoutées');

  // READ avec chemin complet
  debugPrint('\n READ avec hiérarchie :');
  for (final loc in box.values) {
    final path = _getFullPath(loc, box.values.toList());
    debugPrint('   - $path');
  }
}

// Helper pour afficher "Cuisine › Frigo"
String _getFullPath(LocationModel loc, List<LocationModel> all) {
  if (loc.parentId == null) return loc.name;
  final parent = all.firstWhere((l) => l.id == loc.parentId);
  return '${parent.name} › ${loc.name}';
}
