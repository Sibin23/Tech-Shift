class FavModel {
  String? id;
  String? image;
  String? name;
  String? oldPrice;
  String? newPrice;
  bool? fav;

  FavModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.oldPrice,
      required this.newPrice,
      required this.fav});

  factory FavModel.toMap(Map<String, dynamic> map) {
    return FavModel(
      id: map['id'] as String,
      image: map['image'] as String,
      name: map['name'] as String,
      oldPrice: map['oldprice'] as String,
      newPrice: map['newprice'] as String,
      fav: map['fav'] as bool,
    );
  }


}
