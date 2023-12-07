// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Novels with ChangeNotifier {
  List<Book>? data;
  String? message;
  String? status;

  Novels({required this.data, required this.message, required this.status});

  Novels.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Book.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Book with ChangeNotifier {
  String? sId;
  String? name;
  String? publisher;
  String? author;
  String? category;
  bool? isContinue;
  bool? active;
  List<String>? reader;
  List<String>? downloader;
  List<String>? chapters;
  String? summery;
  List<String>? images;
  List<String>? novelRating;
  bool? availability;
  String? iSBN;
  String? language;
  String? genre;
  int? iV;
  String? updatedAt;
  String? createdAt;

  Book({
    required this.sId,
    required this.name,
    required this.publisher,
    required this.author,
    required this.category,
    required this.isContinue,
    required this.active,
    required this.reader,
    required this.downloader,
    required this.chapters,
    required this.summery,
    required this.images,
    required this.novelRating,
    required this.availability,
    required this.iSBN,
    required this.language,
    required this.genre,
    required this.iV,
    required this.updatedAt,
    required this.createdAt,
  });

  Book.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    publisher = json['publisher'];
    author = json['author'];
    category = json['category'];
    isContinue = json['isContinue'];
    active = json['active'];
    reader = json['Reader'].cast<String>();
    downloader = json['Downloader'].cast<String>();
    chapters = json['chapters'].cast<String>();
    summery = json['summery'];
    images = json['images'].cast<String>();
    novelRating = json['novel_rating'].cast<String>();
    availability = json['availability'];
    iSBN = json['iSBN'];
    language = json['language'];
    genre = json['genre'];
    iV = json['__v'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['publisher'] = publisher;
    data['author'] = author;
    data['category'] = category;
    data['isContinue'] = isContinue;
    data['active'] = active;
    data['Reader'] = reader;
    data['Downloader'] = downloader;
    data['chapters'] = chapters;
    data['summery'] = summery;
    data['images'] = images;
    data['novel_rating'] = novelRating;
    data['availability'] = availability;
    data['iSBN'] = iSBN;
    data['language'] = language;
    data['genre'] = genre;
    data['__v'] = iV;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sId': sId,
      'name': name,
      'publisher': publisher,
      'author': author,
      'category': category,
      'isContinue': isContinue,
      'active': active,
      'reader': reader,
      'downloader': downloader,
      'chapters': chapters,
      'summery': summery,
      'images': images,
      'novelRating': novelRating,
      'availability': availability,
      'iSBN': iSBN,
      'language': language,
      'genre': genre,
      'iV': iV,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      sId: map['sId'] != null ? map['sId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      publisher: map['publisher'] != null ? map['publisher'] as String : null,
      author: map['author'] != null ? map['author'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      isContinue: map['isContinue'] != null ? map['isContinue'] as bool : null,
      active: map['active'] != null ? map['active'] as bool : null,
      reader: map['reader'] != null
          ? List<String>.from((map['reader'] as List<String>))
          : null,
      downloader: map['downloader'] != null
          ? List<String>.from((map['downloader'] as List<String>))
          : null,
      chapters: map['chapters'] != null
          ? List<String>.from((map['chapters'] as List<String>))
          : null,
      summery: map['summery'] != null ? map['summery'] as String : null,
      images: map['images'] != null
          ? List<String>.from((map['images'] as List<String>))
          : null,
      novelRating: map['novelRating'] != null
          ? List<String>.from((map['novelRating'] as List<String>))
          : null,
      availability:
          map['availability'] != null ? map['availability'] as bool : null,
      iSBN: map['iSBN'] != null ? map['iSBN'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      genre: map['genre'] != null ? map['genre'] as String : null,
      iV: map['iV'] != null ? map['iV'] as int : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}
