// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_store/domain/entities/product.dart';

class ProductModel {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;
  bool isFavorite;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
    this.isFavorite = false,
  });

  factory ProductModel.fromEntity(Product entity) => ProductModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        price: entity.price,
        discountPercentage: entity.discountPercentage,
        rating: entity.rating,
        stock: entity.stock,
        brand: entity.brand,
        category: entity.category,
        thumbnail: entity.thumbnail,
        images: entity.images,
        isFavorite: entity.isFavorite,
      );

  Product toEntity() => Product(
      id: id,
      title: title,
      description: description,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      brand: brand,
      category: category,
      thumbnail: thumbnail,
      images: images,
      isFavorite: isFavorite);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'category': category,
      'thumbnail': thumbnail,
      'images': images,
      'isFavorite': isFavorite,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        id: map['id'] != null ? map['id'] as int : null,
        title: map['title'] != null ? map['title'] as String : null,
        description:
            map['description'] != null ? map['description'] as String : null,
        price: map['price'] != null ? map['price'] as int : null,
        discountPercentage: map['discountPercentage'] != null
            ? map['discountPercentage'] as double
            : null,
        rating:
            map['rating'] != null ? (map['rating'] as num).toDouble() : null,
        stock: map['stock'] != null ? map['stock'] as int : null,
        brand: map['brand'] != null ? map['brand'] as String : null,
        category: map['category'] != null ? map['category'] as String : null,
        thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
        images: map['images'] != null
            ? List<String>.from((map['images'] as List))
            : null,
        isFavorite:
            map['isFavorite'] != null ? map['isFavorite'] as bool : false);
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.discountPercentage == discountPercentage &&
        other.rating == rating &&
        other.stock == stock &&
        other.brand == brand &&
        other.category == category &&
        other.thumbnail == thumbnail &&
        listEquals(other.images, images) &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        discountPercentage.hashCode ^
        rating.hashCode ^
        stock.hashCode ^
        brand.hashCode ^
        category.hashCode ^
        thumbnail.hashCode ^
        images.hashCode ^
        isFavorite.hashCode;
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, description: $description, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, brand: $brand, category: $category, thumbnail: $thumbnail, images: $images, isFavorite: $isFavorite)';
  }

  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    int? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    String? brand,
    String? category,
    String? thumbnail,
    List<String>? images,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
