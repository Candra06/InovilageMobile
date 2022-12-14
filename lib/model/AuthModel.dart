class AuthModel {
  AuthModel({
    this.name,
    this.email,
    this.phone,
    this.latAddress,
    this.longAddress,
    this.status,
    this.role,
    this.alamat,
    this.saldo,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? name, email, phone, status, role, alamat, latAddress, longAddress;
  DateTime? updatedAt, createdAt;
  int? saldo, id;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        status: json["status"] ?? "",
        role: json["role"] ?? "",
        alamat: json["alamat"] ?? "",
        latAddress: json["lat_address"] ?? "",
        longAddress: json["long_address"] ?? "",
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        saldo: int.parse(json["saldo"].toString()),
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name ?? "",
        "email": email ?? "",
        "phone": phone ?? "",
        "status": status ?? "",
        "lat_ddress": latAddress ?? "",
        "long_address": longAddress ?? "",
        "role": role ?? "User",
        "alamat": alamat ?? "",
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "saldo": saldo ?? 0,
        "id": id ?? 0,
      };
}
