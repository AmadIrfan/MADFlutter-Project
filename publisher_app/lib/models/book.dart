import 'package:flutter/foundation.dart';

class Books with ChangeNotifier {
  List<BookValue>? data;
  String? message;
  String? status;

  Books({this.data, this.message, this.status});

  Books.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BookValue>[];
      json['data'].forEach((v) {
        data!.add(BookValue.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class BookValue with ChangeNotifier {
  String? sId;
  String? name;
  String? publisher;
  String? author;
  String? category;
  bool? isContinue;
  bool? active;
  List<String?>? reader;
  List<String?>? downloader;
  List<String?>? chapters;
  String? summery;
  List<String?>? images;
  List<String?>? novelRating;
  bool? availability;
  String? iSBN;
  String? language;
  String? genre;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BookValue(
      {this.sId,
      this.name,
      this.publisher,
      this.author,
      this.category,
      this.isContinue,
      this.active,
      this.reader,
      this.downloader,
      this.chapters,
      this.summery,
      this.images,
      this.novelRating,
      this.availability,
      this.iSBN,
      this.language,
      this.genre,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BookValue.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
}
