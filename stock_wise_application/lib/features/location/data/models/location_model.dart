import 'package:hive/hive.dart';
part 'location_model.g.dart';

@HiveType(typeId: 1)
class LocationModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String? parentId;

  LocationModel({required this.id, required this.name, this.parentId});
}
