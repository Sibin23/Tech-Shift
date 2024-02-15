import 'package:hive/hive.dart';
part'user_model.g.dart';
@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phNum;
  @HiveField(3)
  final String city;
  @HiveField(4)
  final String state;
  @HiveField(5)
  final String pincode;
  @HiveField(6)
  final String home;
  @HiveField(7)
  final String street;
  UserModel(
      {required this.name,
      required this.phNum,
      required this.city,
      required this.state,
      required this.pincode,
      required this.home,
      required this.street, this.id});
}
