class PengirimanModel {
  PengirimanModel({
    this.id,
    this.tanggal,
    this.kodeTransaksi,
    this.pengirimId,
    this.kurirId,
    this.name,
    this.alamatJemput,
    this.latAddress,
    this.longAddress,
    this.totalPrice,
    this.totalVolume,
    this.status,
    this.jenisSampah,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? kodeTransaksi,
      pengirimId,
      name,
      kurirId,
      alamatJemput,
      latAddress,
      longAddress,
      totalPrice,
      totalVolume,
      status,
      jenisSampah;
  DateTime? tanggal, createdAt, updatedAt;

  factory PengirimanModel.fromJson(Map<String, dynamic> json) =>
      PengirimanModel(
        id: json["id"] ?? 0,
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        kodeTransaksi: json["kode_transaksi"] ?? "",
        pengirimId: json["pengirim_id"].toString(),
        name: json["name"] ?? "",
        kurirId: json["kurir_id"].toString(),
        alamatJemput: json["alamat_jemput"] ?? "",
        latAddress: json["lat_address"] ?? "",
        longAddress: json["long_address"] ?? "",
        totalPrice: json["total_price"].toString(),
        totalVolume: json["total_volume"].toString(),
        status: json["status"] ?? "",
        jenisSampah: json["jenis_sampah"] ?? "",
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
            : "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}"
                .toString(),
        "kode_transaksi": kodeTransaksi ?? "",
        "pengirim_id": pengirimId ?? "",
        "kurir_id": kurirId ?? "",
        "name": name ?? "",
        "alamat_jemput": alamatJemput ?? "",
        "lat_address": latAddress ?? "",
        "long_address": longAddress ?? "",
        "total_price": totalPrice ?? "",
        "total_volume": totalVolume ?? "",
        "status": status ?? "",
        "jenis_sampah": jenisSampah ?? "",
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
