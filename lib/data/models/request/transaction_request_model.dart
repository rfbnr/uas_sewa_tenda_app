import 'dart:convert';

class TransactionRequestModel {
  final String? namaPenyewa;
  final String? email;
  final String? noHp;
  final String? namaTenda;
  final int? jumlahTenda;
  final String? tanggalMulaiSewa;
  final String? tanggalSelesaiSewa;
  final String? metodePembayaran;
  final int? totalHarga;

  TransactionRequestModel({
    this.namaPenyewa,
    this.email,
    this.noHp,
    this.namaTenda,
    this.jumlahTenda,
    this.tanggalMulaiSewa,
    this.tanggalSelesaiSewa,
    this.metodePembayaran,
    this.totalHarga,
  });

  factory TransactionRequestModel.fromRawJson(String str) =>
      TransactionRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionRequestModel.fromJson(Map<String, dynamic> json) =>
      TransactionRequestModel(
        namaPenyewa: json["nama_penyewa"],
        email: json["email"],
        noHp: json["no_hp"],
        namaTenda: json["nama_tenda"],
        jumlahTenda: json["jumlah_tenda"],
        tanggalMulaiSewa: json["tanggal_mulai_sewa"],
        tanggalSelesaiSewa: json["tanggal_selesai_sewa"],
        metodePembayaran: json["metode_pembayaran"],
        totalHarga: json["total_harga"],
      );

  Map<String, dynamic> toJson() => {
        "nama_penyewa": namaPenyewa,
        "email": email,
        "no_hp": noHp,
        "nama_tenda": namaTenda,
        "jumlah_tenda": jumlahTenda,
        "tanggal_mulai_sewa": tanggalMulaiSewa,
        "tanggal_selesai_sewa": tanggalSelesaiSewa,
        "metode_pembayaran": metodePembayaran,
        "total_harga": totalHarga,
      };
}
