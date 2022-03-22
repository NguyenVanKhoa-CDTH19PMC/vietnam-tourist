class Comment {
  int? id;
  int? postId;
  int? userId;
  String? content;
  DateTime createdAt = DateTime(0);

  Comment({
    this.id,
    this.postId,
    this.userId,
    this.content,
    required this.createdAt,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.postId = json["postId"];
    this.userId = json["userId"];
    this.content = json["content"];
    this.createdAt = DateTime(
        int.parse(json["created_at"].substring(0, 4)),
        int.parse(json["created_at"].substring(5, 7)),
        int.parse(json["created_at"].substring(8, 10)),
        int.parse(json["created_at"].substring(11, 13)),
        int.parse(json["created_at"].substring(14, 16)),
        int.parse(json["created_at"].substring(17, 19)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["postId"] = this.postId;
    data["userId"] = this.userId;
    data["content"] = this.content;
    data["created_at"] = this.createdAt;
    return data;
  }
}
