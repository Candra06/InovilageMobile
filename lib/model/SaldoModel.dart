class SaldoModel {
  SaldoModel({
    this.id,
    this.tanggal,
    this.usersId,
    this.createdBy,
    this.jumlahTransaksi,
    this.jenis,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? usersId, createdBy, jumlahTransaksi, jenis, name;
  DateTime? tanggal, createdAt, updatedAt;

  factory SaldoModel.fromJson(Map<String, dynamic> json) => SaldoModel(
        id: json["id"] ?? 0,
        usersId: json["users_id"] ?? "",
        createdBy: json["created_by"] ?? "",
        jumlahTransaksi: json["jumlah_transaksi"] ?? "",
        jenis: json["jenis"] ?? "",
        name: json["name"] ?? "",
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "tanggal": tanggal == null
            ? null
            : "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "users_id": usersId ?? "",
        "created_by": createdBy ?? "",
        "jumlah_transaksi": jumlahTransaksi ?? "",
        "jenis": jenis ?? "",
        "name": name ?? "",
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
