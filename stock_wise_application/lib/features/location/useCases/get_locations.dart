import 'package:stock_wise_application/features/location/data/models/location_model.dart';
import 'package:stock_wise_application/features/location/data/repository/location_repository.dart';

class GetLocations {
  final LocationRepository _repository;

  GetLocations(this._repository);

  List<LocationModel> call() => _repository.getLocations();
}
