import 'package:stock_wise_application/features/location/data/models/location_model.dart';
import 'package:stock_wise_application/features/location/data/repository/location_repository.dart';

class UpdateLocation {
  final LocationRepository _repository;

  UpdateLocation(this._repository);

  Future<void> call(String id, LocationModel location) async {
    await _repository.updateLocation(id, location);
  }
}
