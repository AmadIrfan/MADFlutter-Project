import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/chapter_response.dart';
import '/models/book.dart';
import '/models/books_data.dart';
import '../../models/author_response.dart';
import 'api_route.dart';

// to handle api calls
class APICalls extends ChangeNotifier {
  // final LocalStorage _ls = LocalStorage();

  // update books
  Future<AuthorResponse> updateBooks(BookModel books, String id) async {
    try {
      Response response = await put(
        Uri.parse('$url$book$route$id'),
        body: json.encode(books.toMap()),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      AuthorResponse ar =
          AuthorResponse.fromJson(json.decode(response.body.toString()));
      return ar;
    } catch (e) {
      rethrow;
    }
  }

//  get and view books
  Future<Books> getBooks(String query) async {
    try {
      Response response = await get(
        Uri.parse('$url$book$route?$query'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      Books ar = Books.fromJson(json.decode(response.body.toString()));
      return ar;
    } catch (e) {
      rethrow;
    }
  }

// status change active or inactive
  Future<AuthorResponse> bookContinueStatusChange(
      bool active, String id) async {
    try {
      Response response = await put(Uri.parse('$url$book${route}continue/$id'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({'isContinue': active}));
      AuthorResponse ar =
          AuthorResponse.fromJson(json.decode(response.body.toString()));
      return ar;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> chapterStatusChange(bool active, String id) async {
    try {
      Response response = await put(
        Uri.parse('$url$chapter$route$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'active': active}),
      );
      // ChaptersResponse ar =
      //     ChaptersResponse.fromJson(json.decode(response.body.toString()));
      if (response.statusCode == 200) {
      } else {
        throw 'Error book Chapter is not active';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ChaptersResponse> getChapters(String id) async {
    try {
      Response response = await get(
        Uri.parse('$url$chapter$route$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      ChaptersResponse ar =
          ChaptersResponse.fromJson(json.decode(response.body.toString()));
      return ar;
    } catch (e) {
      rethrow;
    }
  }

// status change active or inactive
  Future<AuthorResponse> bookStatusChange(bool active, String id) async {
    try {
      Response response = await put(Uri.parse('$url$book${route}active/$id'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({'active': active}));
      AuthorResponse ar =
          AuthorResponse.fromJson(json.decode(response.body.toString()));
      return ar;
    } catch (e) {
      rethrow;
    }
  }

// send email function using admin dashboard
  Future<void> sendEmail(Map<String, dynamic> data) async {
    try {
      Response response = await post(
        Uri.parse('$url$email$route'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      if (response.statusCode != 200) {
        throw 'error in sending email';
      }
    } catch (e) {
      rethrow;
    }
  }
}
