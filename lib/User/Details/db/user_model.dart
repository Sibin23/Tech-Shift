import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String oldPrice;
  @HiveField(4)
  final String newPrice;
  @HiveField(5)
  final String? imageUrl;
  

  UserModel({
    required this.id,
    required this.name,
    required this.category,
    required this.oldPrice,
    required this.newPrice,
    required this.imageUrl,
  });
  static fromMap(Map<String, dynamic> user) {
    return UserModel(
        id: user['id'],
        name: user['name'],
        category: user['category'],
        oldPrice: user['oldprice'],
        newPrice: user['newprice'],
        imageUrl: user['image'],
        );
       
  }
}
