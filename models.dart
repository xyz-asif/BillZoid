
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? name,category;
  int? cost, stock;

  Product({
    required this.name,
    required this.cost,
    required this.stock,
    required this.category,
  });
  @override
  toString() => '$name';

  Product.fromMap(Map<String, dynamic> map) {
    name = map["name"];
    cost = map["cost"]  ;
    stock = map["stock"] ;
    category = map["category"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "cost": cost,
      "stock": stock,
      "category":category
    };
  }

  static Product fromsnapshot(DocumentSnapshot snap){
    Product product = Product(name: snap['name'], cost: snap['cost'], stock: snap['stock'], category: snap["category"]);
    return product;
  }
}


