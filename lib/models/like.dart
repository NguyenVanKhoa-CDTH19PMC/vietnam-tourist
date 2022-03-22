class Like {
  int? id;
  int? postId;
  int? userId;
  int? like;
  String? createdAt;

  Like({
    this.id,
    this.postId,
    this.userId,
    this.like,
    this.createdAt,
  });

  Like.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.postId = json["postId"];
    this.userId = json["userId"];
    this.like = json["like"];
    this.createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["postId"] = this.postId;
    data["userId"] = this.userId;
    data["like"] = this.like;
    data["created_at"] = this.createdAt;
    return data;
  }
}
