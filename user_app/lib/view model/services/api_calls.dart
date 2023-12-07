import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/novel.dart';
import '../../models/chapter_model.dart';
import '../../view%20model/services/routes.dart';

class ApiCalls with ChangeNotifier {
  Future<Novels> getLatestPublications() async {
    try {
      Response response = await get(
        Uri.parse('$api$book$routes?active=true'),
      );
      Novels nvl = Novels.fromJson(json.decode(response.body.toString()));
      return nvl;
    } catch (e) {
      rethrow;
    }
  }

  Future<ChaptersResponse> getChapters(String id) async {
    try {
      Response response = await get(
        Uri.parse('$api$chapter$routes$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      ChaptersResponse ar = ChaptersResponse.fromJson(
        json.decode(
          response.body.toString(),
        ),
      );
      return ar;
    } catch (e) {
      rethrow;
    }
  }

  Future<ChaptersResponse> getRatingOfBook(String id) async {
    try {
      Response response = await get(
        Uri.parse('$api$chapter$routes$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      ChaptersResponse ar = ChaptersResponse.fromJson(
        json.decode(
          response.body.toString(),
        ),
      );
      return ar;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setRating(Map<String, dynamic> data) async {
    try {
      await post(
        Uri.parse('$api$rating$routes'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
    } catch (e) {
      rethrow;
    }
  }
}
