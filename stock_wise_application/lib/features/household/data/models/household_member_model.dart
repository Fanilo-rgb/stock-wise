import 'package:hive/hive.dart';
part 'household_member_model.g.dart';

@HiveType(typeId: 4)
class HouseholdMemberModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String role;

  HouseholdMemberModel({
    required this.id,
    required this.name,
    required this.role,
  });
}
