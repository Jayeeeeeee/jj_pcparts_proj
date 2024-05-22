class Product {
  final String id;
  final String pname;
  final String pprice;
  final String pdescription;
  final String rating;
  final String imageUrl;
  final String pcategory;

  Product({
    required this.id,
    required this.pname,
    required this.pprice,
    required this.pdescription,
    required this.rating,
    required this.imageUrl,
    required this.pcategory,
  });

  get product => null;

  //String get _imagePath => pimagePath;

  static Product fromJson(Map<String, dynamic> json) => Product(
      id: json['id'],
      pname: json['pname'],
      pprice: json['pprice'],
      rating: json['rating'],
      pdescription: json['pdescription'],
      imageUrl: json['imageUrl'],
      pcategory: json['pcategory']);
  Map<String, dynamic> toJson() => {
        'id': id,
        'pname': pname,
        'pprice': pprice,
        'rating': rating,
        'pdescription': pdescription,
        'imageUrl': imageUrl,
        'pcategory': pcategory,
      };
}
