import 'package:stock_wise_application/features/location/data/models/location_model.dart';
import 'package:stock_wise_application/features/location/data/repository/location_repository.dart';

class SaveLocation {
  final LocationRepository _repository;

  SaveLocation(this._repository);

  Future<void> call(LocationModel location) async {
    await _repository.saveLocation(location);
  }
}
