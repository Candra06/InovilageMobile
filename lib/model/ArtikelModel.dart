class ArtikelModel {
  ArtikelModel({
    this.id,
    this.judul,
    this.konten,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? judul, konten, status;
  DateTime? createdAt, updatedAt;

  factory ArtikelModel.fromJson(Map<String, dynamic> json) => ArtikelModel(
        id: json["id"] ?? 0,
        judul: json["judul"] ?? "",
        konten: json["konten"] ?? "",
        status: json["status"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "judul": judul ?? "",
        "konten": konten ?? "",
        "status": status ?? "",
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
