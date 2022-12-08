class DetailPengirimanModel {
  DetailPengirimanModel({
    this.kodeTransaksi,
    this.kurir,
    this.alamatJemput,
    this.status,
    this.jenisSampah,
    this.totalamount,
    this.totalVolume,
    this.adminfee,
    this.kurirfee,
    this.netamount,
    this.latAddress,
    this.longAddress,
    this.itemOrganik,
    this.itemAnorganik,
    this.tanggal,
    this.createdAt,
  });

  String? kodeTransaksi,
      kurir,
      alamatJemput,
      status,
      totalamount,
      jenisSampah,
      latAddress,
      totalVolume,
      longAddress;
  int? adminfee, netamount, kurirfee;
  List<Item>? itemOrganik;
  List<Item>? itemAnorganik;
  DateTime? tanggal, createdAt;

  factory DetailPengirimanModel.fromJson(Map<String, dynamic> json) =>
      DetailPengirimanModel(
        kodeTransaksi: json["kode_transaksi"] ?? "",
        kurir: json["kurir"] ?? "",
        alamatJemput: json["alamat_jemput"] ?? "",
        latAddress: json["lat_address"],
        longAddress: json["long_address"],
        totalVolume: json["total_volume"].toString(),
        jenisSampah: json["jenis_sampah"] ?? "",
        status: json["status"] ?? "",
        totalamount: json["totalamount"].toString(),
        adminfee: json["adminfee"] ?? 0,
        kurirfee: json["kurirfee"] ?? 0,
        netamount: json["netamount"] ?? 0,
        itemOrganik: json["item_organik"] == null
            ? []
            : List<Item>.from(
                json["item_organik"].map((x) => Item.fromJson(x))),
        itemAnorganik: json["item_anorganik"] == null
            ? []
            : List<Item>.from(
                json["item_anorganik"].map((x) => Item.fromJson(x))),
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "kode_transaksi": kodeTransaksi ?? "",
        "kurir": kurir ?? "",
        "alamat_jemput": alamatJemput ?? "",
        "jenis_sampah": jenisSampah ?? "",
        "lat_address": latAddress,
        "total_volume": totalVolume,
        "long_address": longAddress,
        "status": status ?? "",
        "totalamount": totalamount ?? "",
        "adminfee": adminfee ?? 0,
        "kurirfee": kurirfee ?? 0,
        "netamount": netamount ?? 0,
        "tanggal": tanggal == null
            ? null
            : "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "item_organik": itemOrganik == null
            ? null
            : List<dynamic>.from(itemOrganik!.map((x) => x)),
        "item_anorganik": itemAnorganik == null
            ? null
            : List<dynamic>.from(itemAnorganik!.map((x) => x)),
      };
}

class Item {
  Item({
    this.jenis,
    this.nama,
    this.satuan,
    this.volume,
    this.hargaSatuan,
    this.hargaTotal,
  });

  String? jenis, nama, satuan, volume, hargaSatuan, hargaTotal;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        jenis: json["jenis"] ?? "",
        nama: json["nama"] ?? "",
        satuan: json["satuan"] ?? "",
        volume: json["volume"].toString(),
        hargaSatuan: json["harga_satuan"].toString(),
        hargaTotal: json["harga_total"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "jenis": jenis ?? "",
        "nama": nama ?? "",
        "satuan": satuan ?? "",
        "volume": volume ?? "",
        "harga_satuan": hargaSatuan ?? "",
        "harga_total": hargaTotal ?? "",
      };
}
