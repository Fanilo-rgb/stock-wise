import 'package:stock_wise_application/features/location/data/repository/location_repository.dart';

class DeleteLocation {
  final LocationRepository _repository;

  DeleteLocation(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteLocation(id);
  }
}
