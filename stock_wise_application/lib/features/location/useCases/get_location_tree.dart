import 'package:stock_wise_application/features/location/data/models/location_model.dart';
import 'package:stock_wise_application/features/location/data/repository/location_repository.dart';

class GetLocationTree {
  final LocationRepository _repository;

  GetLocationTree(this._repository);

  List<LocationModel> call(String locationId, {int maxAncestors = 1}) {
    final List<LocationModel> tree = [];
    String? currentId = locationId;

    int remainingSteps = maxAncestors + 1;

    while (currentId != null && remainingSteps > 0) {
      final location = _repository.getLocationById(currentId);

      if (location != null) {
        tree.add(location);
        currentId = location.parentId;
        remainingSteps--;
      } else {
        break;
      }
    }

    return tree.reversed.toList();
  }
}
