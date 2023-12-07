// to handle Rating
class RatingModel {
  List<Rating>? data;
  String? message;
  String? status;

  RatingModel({this.data, this.message, this.status});

  RatingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Rating>[];
      json['data'].forEach((v) {
        data!.add(Rating.fromJson(v));
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

class Rating {
  String? sId;
  String? userId;
  String? novelId;
  String? feedback;
  int? rating;
  bool? active;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Rating({
    this.sId,
    this.userId,
    this.novelId,
    this.feedback,
    this.rating,
    this.active,
    this.iV,
    this.createdAt,
    this.updatedAt,
  });

  Rating.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    novelId = json['novelId'];
    feedback = json['feedback'];
    rating = json['Rating'];
    active = json['active'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['novelId'] = novelId;
    data['feedback'] = feedback;
    data['Rating'] = rating;
    data['active'] = active;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
