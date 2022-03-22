class Type {
  int? id;
  int? placenameId;
  String? type;
  String? createdAt;

  Type({
    this.id,
    this.placenameId,
    this.type,
    this.createdAt,
  });

  Type.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.placenameId = json["placenameId"];
    this.type = json["type"];
    this.createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["placenameId"] = this.placenameId;

    data["type"] = this.type;
    data["created_at"] = this.createdAt;
    return data;
  }
}
