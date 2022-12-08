class TrashModel {
  TrashModel({
    this.id,
    this.jenis,
    this.nama,
    this.satuan,
    this.harga,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? jenis, nama, satuan, harga;
  DateTime? createdAt, updatedAt;

  factory TrashModel.fromJson(Map<String, dynamic> json) => TrashModel(
        id: json["id"] ?? 0,
        harga: json["harga"].toString(),
        jenis: json["jenis"] ?? "",
        nama: json["nama"] ?? "",
        satuan: json["satuan"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "harga": harga ?? 0,
        "jenis": jenis ?? "",
        "nama": nama ?? "",
        "satuan": satuan ?? "",
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
