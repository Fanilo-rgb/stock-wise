import 'package:hive/hive.dart';
import 'household_member_model.dart';
part 'household_model.g.dart';

@HiveType(typeId: 3)
class HouseholdModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<HouseholdMemberModel> members;

  HouseholdModel({required this.id, required this.name, required this.members});
}
