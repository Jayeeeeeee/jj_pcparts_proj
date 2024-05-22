class Order {
  final String id;
  final String fname;
  final String message;
  final String address;
  final String totalprice;
  final String contactNumber;
  final List<Map<String, dynamic>> products;

  Order({
    required this.id,
    required this.fname,
    required this.address,
    required this.message,
    required this.totalprice,
    required this.contactNumber,
    required this.products,
  });

  static Order fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        fname: json['fname'],
        message: json['message'],
        address: json['address'],
        totalprice: json['totalprice'],
        contactNumber: json['contactNumber'],
        products: List<Map<String, dynamic>>.from(json['products']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fname': fname,
        'message': message,
        'address': address,
        'totalprice': totalprice,
        'contactNumber': contactNumber,
        'products': products,
      };
}
