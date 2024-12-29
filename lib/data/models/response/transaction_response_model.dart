import 'dart:convert';

class TransactionResponseModel {
  final String? status;
  final String? message;
  final List<TransactionResultResponseModel>? data;

  TransactionResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory TransactionResponseModel.fromRawJson(String str) =>
      TransactionResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TransactionResultResponseModel>.from(json["data"]!
                .map((x) => TransactionResultResponseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TransactionResultResponseModel {
  final int? id;
  final String? namaPenyewa;
  final String? email;
  final String? noHp;
  final String? namaTenda;
  final int? jumlahTenda;
  final String? statusPenyewaan;
  final DateTime? tanggalMulaiSewa;
  final DateTime? tanggalSelesaiSewa;
  final DateTime? tanggalPengembalian;
  final int? durasiSewa;
  final DateTime? tanggalTransaksi;
  final String? statusPembayaran;
  final String? metodePembayaran;
  final int? totalHarga;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransactionResultResponseModel({
    this.id,
    this.namaPenyewa,
    this.email,
    this.noHp,
    this.namaTenda,
    this.jumlahTenda,
    this.statusPenyewaan,
    this.tanggalMulaiSewa,
    this.tanggalSelesaiSewa,
    this.tanggalPengembalian,
    this.durasiSewa,
    this.tanggalTransaksi,
    this.statusPembayaran,
    this.metodePembayaran,
    this.totalHarga,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionResultResponseModel.fromRawJson(String str) =>
      TransactionResultResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionResultResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionResultResponseModel(
        id: json["id"],
        namaPenyewa: json["nama_penyewa"],
        email: json["email"],
        noHp: json["no_hp"],
        namaTenda: json["nama_tenda"],
        jumlahTenda: json["jumlah_tenda"],
        statusPenyewaan: json["status_penyewaan"],
        tanggalMulaiSewa: json["tanggal_mulai_sewa"] == null
            ? null
            : DateTime.parse(json["tanggal_mulai_sewa"]),
        tanggalSelesaiSewa: json["tanggal_selesai_sewa"] == null
            ? null
            : DateTime.parse(json["tanggal_selesai_sewa"]),
        tanggalPengembalian: json["tanggal_pengembalian"] == null
            ? null
            : DateTime.parse(json["tanggal_pengembalian"]),
        durasiSewa: json["durasi_sewa"],
        tanggalTransaksi: json["tanggal_transaksi"] == null
            ? null
            : DateTime.parse(json["tanggal_transaksi"]),
        statusPembayaran: json["status_pembayaran"],
        metodePembayaran: json["metode_pembayaran"],
        totalHarga: json["total_harga"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_penyewa": namaPenyewa,
        "email": email,
        "no_hp": noHp,
        "nama_tenda": namaTenda,
        "jumlah_tenda": jumlahTenda,
        "status_penyewaan": statusPenyewaan,
        "tanggal_mulai_sewa": tanggalMulaiSewa?.toIso8601String(),
        "tanggal_selesai_sewa": tanggalSelesaiSewa?.toIso8601String(),
        "tanggal_pengembalian": tanggalPengembalian?.toIso8601String(),
        "durasi_sewa": durasiSewa,
        "tanggal_transaksi": tanggalTransaksi?.toIso8601String(),
        "status_pembayaran": statusPembayaran,
        "metode_pembayaran": metodePembayaran,
        "total_harga": totalHarga,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
