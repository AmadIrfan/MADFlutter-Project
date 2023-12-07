import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookModel {
  String? author;
  String? category;
  String? name;
  String? publisher;
  String? summery;
  List<String>? images;
  String? iSBN;
  String? language;
  String? genre;
  BookModel({
    required this.author,
    required this.category,
    required this.name,
    required this.publisher,
    required this.summery,
    required this.images,
    required this.iSBN,
    required this.language,
    required this.genre,
  });

  BookModel copyWith({
    String? author,
    String? category,
    String? name,
    String? publisher,
    String? summery,
    List<String>? images,
    String? iSBN,
    String? language,
    String? genre,
  }) {
    return BookModel(
      author: author ?? this.author,
      category: category ?? this.category,
      name: name ?? this.name,
      publisher: publisher ?? this.publisher,
      summery: summery ?? this.summery,
      images: images ?? this.images,
      iSBN: iSBN ?? this.iSBN,
      language: language ?? this.language,
      genre: genre ?? this.genre,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author': author,
      'category': category,
      'name': name,
      'publisher': publisher,
      'summery': summery,
      'images': images,
      'iSBN': iSBN,
      'language': language,
      'genre': genre,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      author: map['author'] != null ? map['author'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      publisher: map['publisher'] != null ? map['publisher'] as String : null,
      summery: map['summery'] != null ? map['summery'] as String : null,
      images: map['images'] != null
          ? List<String>.from((map['images'] as List<String>))
          : null,
      iSBN: map['iSBN'] != null ? map['iSBN'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      genre: map['genre'] != null ? map['genre'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookModel(author: $author, category: $category, name: $name, publisher: $publisher, summery: $summery, images: $images, iSBN: $iSBN, language: $language, genre: $genre)';
  }

  @override
  bool operator ==(covariant BookModel other) {
    if (identical(this, other)) return true;

    return other.author == author &&
        other.category == category &&
        other.name == name &&
        other.publisher == publisher &&
        other.summery == summery &&
        listEquals(other.images, images) &&
        other.iSBN == iSBN &&
        other.language == language &&
        other.genre == genre;
  }

  @override
  int get hashCode {
    return author.hashCode ^
        category.hashCode ^
        name.hashCode ^
        publisher.hashCode ^
        summery.hashCode ^
        images.hashCode ^
        iSBN.hashCode ^
        language.hashCode ^
        genre.hashCode;
  }
}
