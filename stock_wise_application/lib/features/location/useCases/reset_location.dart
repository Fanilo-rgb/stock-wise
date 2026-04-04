import 'package:stock_wise_application/features/location/data/repository/location_repository.dart';

class ResetLocation {
  final LocationRepository _repository;

  ResetLocation(this._repository);

  Future<void> call() async {
    await _repository.clearAll();
  }
}
