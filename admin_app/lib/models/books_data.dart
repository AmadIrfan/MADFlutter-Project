import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// book model
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
  // constructor
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

// to json form model
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

// from json to model
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

// json encoding and decoding
  String toJson() => json.encode(toMap());
  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookModel(author: $author, category: $category, name: $name, publisher: $publisher, summery: $summery, images: $images, iSBN: $iSBN, language: $language, genre: $genre)';
  }
}
