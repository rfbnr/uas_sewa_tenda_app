import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas_sewa_tenda_app/core/extension/int_currency_ext.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/response/transaction_response_model.dart';

class TransactionCardItemWidget extends StatelessWidget {
  const TransactionCardItemWidget({
    super.key,
    required this.data,
    this.onPressed,
  });

  final TransactionResultResponseModel data;
  final Function()? onPressed;

  IconData getIconStatus(String status) {
    switch (status) {
      case "disewa":
        return Icons.sync_outlined;
      case "dikembalikan":
        return Icons.done_all;
      default:
        return Icons.sync_outlined;
    }
  }

  Color getColorIconStatus(String status) {
    switch (status) {
      case "disewa":
        return Colors.blue;
      case "dikembalikan":
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          useSafeArea: true,
          isDismissible: true,
          // useRootNavigator: true,
          enableDrag: true,
          isScrollControlled: true,
          builder: (context) {
            return _buildDetailBottomSheet(
              context: context,
              data: data,
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 24,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/tenda.png",
                  height: 60,
                  fit: BoxFit.cover,
                ),
                SpaceWidth(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.namaPenyewa ?? "-",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SpaceHeight(4),
                    Text(
                      "Tenda: ${data.namaTenda ?? "-"}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Status: ${data.statusPenyewaan ?? "-"}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${data.durasiSewa ?? "-"} Hari Penyewaan",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              getIconStatus(data.statusPenyewaan ?? "disewa"),
              color: getColorIconStatus(data.statusPenyewaan ?? "disewa"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailBottomSheet({
    required BuildContext context,
    required TransactionResultResponseModel data,
  }) {
    final formatterStartDate = DateFormat("dd MMMM yyyy").format(
      data.tanggalMulaiSewa ?? DateTime.now(),
    );

    String formatterEndDate = DateFormat("dd MMMM yyyy").format(
      data.tanggalSelesaiSewa ?? DateTime.now(),
    );

    final formatterCompleteDate = DateFormat("dd MMMM yyyy").format(
      data.tanggalPengembalian ?? DateTime.now(),
    );

    final formatterTransactionDate = DateFormat("dd MMMM yyyy").format(
      data.tanggalTransaksi ?? DateTime.now(),
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.99,
      minChildSize: 0.7,
      maxChildSize: 0.99,
      expand: true,
      builder: (_, scrrolController) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Detail Transaksi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              SpaceHeight(16),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  controller: scrrolController,
                  children: [
                    _buildDetailTransactionItem(
                      title: "Nama Penyewa",
                      value: data.namaPenyewa ?? "-",
                      icon: Icons.person,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Nomor Telepon",
                      value: data.noHp ?? "-",
                      icon: Icons.phone,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Email",
                      value: data.email ?? "-",
                      icon: Icons.email,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Nama Tenda",
                      value: data.namaTenda ?? "-",
                      icon: Icons.cabin,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Jumlah Tenda",
                      value: "${data.jumlahTenda ?? 0} Tenda",
                      icon: Icons.format_list_numbered_rounded,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Status Penyewaan",
                      value: data.statusPenyewaan ?? "-",
                      icon: Icons.sync_outlined,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Tanggal Mulai",
                      value: formatterStartDate,
                      icon: Icons.today,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Tanggal Selesai",
                      value: formatterEndDate,
                      icon: Icons.event,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Tanggal Pengembalian",
                      value: data.tanggalPengembalian == null
                          ? "-"
                          : formatterCompleteDate,
                      icon: Icons.event_available_rounded,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Durasi Sewa",
                      value: "${data.durasiSewa ?? 0} Hari",
                      icon: Icons.timer,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Metode Pembayaran",
                      value: data.metodePembayaran ?? "-",
                      icon: Icons.payment,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Status Pembayaran",
                      value: data.statusPembayaran ?? "-",
                      icon: Icons.payments_rounded,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Tanggal Transaksi",
                      value: formatterTransactionDate,
                      icon: Icons.date_range,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Total Harga",
                      value: data.totalHarga?.currencyFormatRp ?? "Rp 0",
                      icon: Icons.monetization_on,
                    ),
                    SpaceHeight(40),
                    if (data.statusPenyewaan != "dikembalikan")
                      Button.filled(
                        color: AppColors.gradient1,
                        label: "Kembalikan Tenda (${data.namaTenda ?? "-"})",
                        onPressed: onPressed ?? () {},
                      )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailTransactionItem({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SpaceHeight(8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: AppColors.gradient1,
              ),
              SpaceWidth(10),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
