class Picture {
  int? id;
  int? postId;
  String? path;
  String? description;

  Picture({
    this.id,
    this.postId,
    this.path,
    this.description,
  });

  Picture.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.postId = json["postId"];
    this.path = json["path"];
    this.description = json["description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["postId"] = this.postId;
    data["path"] = this.path;
    data["description"] = this.description;
    return data;
  }
}
