import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/location/data/models/location_model.dart';
import 'package:stock_wise_application/features/location/data/repository/location_repository_impl.dart';
import 'package:stock_wise_application/features/location/useCases/delete_location.dart';
import 'package:stock_wise_application/features/location/useCases/get_locations.dart';
import 'package:stock_wise_application/features/location/useCases/reset_location.dart';
import 'package:stock_wise_application/features/location/useCases/save_location.dart';

Future<void> testLocations() async {
  final repository = LocationRepositoryImpl(
    Hive.box<LocationModel>('locations'),
  );

  final resetLocation = ResetLocation(repository);
  final saveLocation = SaveLocation(repository);
  final getLocations = GetLocations(repository);
  final deleteLocation = DeleteLocation(repository);

  await resetLocation.call();

  debugPrint('\n========== LOCATIONS ==========');

  // CREATE parents
  final cuisine = LocationModel(id: 'loc1', name: 'Cuisine');
  final sdb = LocationModel(id: 'loc2', name: 'Salle de bain');
  await saveLocation.call(cuisine);
  await saveLocation.call(sdb);

  // CREATE enfants
  final frigo = LocationModel(id: 'loc3', name: 'Frigo', parentId: 'loc1');
  final placard = LocationModel(id: 'loc4', name: 'Placard', parentId: 'loc1');
  final armoire = LocationModel(id: 'loc5', name: 'Armoire', parentId: 'loc2');
  await saveLocation.call(frigo);
  await saveLocation.call(placard);
  await saveLocation.call(armoire);

  debugPrint('CREATE → ${getLocations.call().length} locations ajoutées');

  // READ avec chemin complet
  debugPrint('\n READ avec hiérarchie :');
  final allLocations = getLocations.call();
  for (final loc in allLocations) {
    final path = _getFullPath(loc, allLocations);
    debugPrint('   - $path');
  }

  // DELETE
  await deleteLocation.call('loc5');
  debugPrint('\n DELETE → ${getLocations.call().length} locations restantes');

  // RESET
  await resetLocation.call();
  debugPrint(
    ' RESET → ${getLocations.call().length} locations après réinitialisation',
  );
}

// Helper temporaire pour afficher "Cuisine › Frigo"
String _getFullPath(LocationModel loc, List<LocationModel> all) {
  if (loc.parentId == null) return loc.name;
  final parent = all.firstWhere((l) => l.id == loc.parentId);
  return '${parent.name} › ${loc.name}';
}
