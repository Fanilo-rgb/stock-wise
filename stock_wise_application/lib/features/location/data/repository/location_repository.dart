import 'package:stock_wise_application/features/location/data/models/location_model.dart';

abstract class LocationRepository {
  List<LocationModel> getLocations();
  LocationModel? getLocationById(String id);
  Future<void> saveLocation(LocationModel location);
  Future<void> deleteLocation(String id);
  Future<void> clearAll();
}
