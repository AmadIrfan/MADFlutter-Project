import 'package:flutter/material.dart';

class ChaptersResponse with ChangeNotifier {
  List<Chapter>? data;
  String? message;
  String? status;

  ChaptersResponse({this.data, this.message, this.status});

  ChaptersResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Chapter>[];
      json['data'].forEach((v) {
        data!.add(Chapter.fromJson(v));
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

class Chapter with ChangeNotifier {
  String? id;
  String? chapterName;
  int? chapterNo;
  String? file;
  String? bookId;
  bool? active;
  List<String>? rating;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Chapter(
      {this.id,
      this.chapterName,
      this.chapterNo,
      this.file,
      this.bookId,
      this.active,
      this.rating,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Chapter.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    chapterName = json['chapterName'];
    chapterNo = json['chapterNo'];
    file = json['file'];
    bookId = json['bookId'];
    active = json['active'];
    rating = json['rating'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['chapterName'] = chapterName;
    data['chapterNo'] = chapterNo;
    data['file'] = file;
    data['bookId'] = bookId;
    data['active'] = active;
    data['rating'] = rating;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
