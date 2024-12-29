import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uas_sewa_tenda_app/core/extension/int_currency_ext.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/datas.dart';
import '../../../data/models/request/transaction_request_model.dart';
import '../../home/screens/dashboard_route.dart';
import '../blocs/transaction_bloc/transaction_bloc.dart';

class TransactionPaymentScreen extends StatefulWidget {
  const TransactionPaymentScreen({
    super.key,
    required this.item,
  });

  final TendaItemModel item;

  @override
  State<TransactionPaymentScreen> createState() =>
      _TransactionPaymentScreenState();
}

class _TransactionPaymentScreenState extends State<TransactionPaymentScreen> {
  String paymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        foregroundColor: AppColors.gradient2,
        title: const Text(
          'Metode Pembayaran',
          style: TextStyle(
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.gradient2,
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.gradient2,
                  AppColors.gradient1,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                SpaceHeight(20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    // color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: AppColors.black.withValues(alpha: 0.5),
                      ),
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(0.8),
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              bottomLeft: Radius.circular(16.0),
                            ),
                            child: Image.asset(
                              "assets/images/tenda.png",
                              height: 80,
                              fit: BoxFit.cover,
                            )),
                      ),
                      SpaceWidth(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SpaceHeight(4.0),
                            Text(
                              "${widget.item.description} / tenda",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.black,
                              ),
                            ),
                            const SpaceHeight(2.0),
                            BlocBuilder<TransactionBloc, TransactionState>(
                              builder: (context, state) {
                                final jumlahTenda = state.jumlahTenda;

                                return Text(
                                  "$jumlahTenda tenda disewa",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            const SpaceHeight(2.0),
                            Text(
                              "${widget.item.price.currencyFormatRp} / tenda",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SpaceHeight(2.0),
                            BlocBuilder<TransactionBloc, TransactionState>(
                              builder: (context, state) {
                                final total = state.totalHarga;

                                return Text(
                                  "Total: ${total.currencyFormatRp}",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            const SpaceHeight(8.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SpaceHeight(40),
              ],
            ),
          ),
          SpaceHeight(20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceHeight(20),
                const Text(
                  'Pilih Metode Pembayaran',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SpaceHeight(20),
                ListView.separated(
                  itemCount: paymentMethodItems.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return SpaceHeight(20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final item = paymentMethodItems[index];

                    return InkWell(
                      onTap: () {
                        setState(() {
                          paymentMethod = item.name;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: paymentMethod == item.name
                              ? AppColors.gradient1
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: paymentMethod == item.name
                                ? AppColors.gradient1
                                : AppColors.grey,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    color: paymentMethod == item.name
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SpaceHeight(2),
                                Text(
                                  '${item.number}',
                                  style: TextStyle(
                                    color: paymentMethod == item.name
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: paymentMethod == item.name
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SpaceHeight(40),
                BlocConsumer<TransactionBloc, TransactionState>(
                  listener: (context, state) {
                    if (state.status == TransactionStatus.success) {
                      final message =
                          state.result?.message ?? "Pemesanan berhasil";

                      EasyLoading.dismiss();
                      EasyLoading.showSuccess(message);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardRoute(),
                        ),
                        (route) => false,
                      );

                      context
                          .read<TransactionBloc>()
                          .add(TransactionSetAllFieldInitial());
                    } else if (state.status == TransactionStatus.failure) {
                      final message = state.error?.message ?? "Pemesanan gagal";

                      EasyLoading.dismiss();
                      EasyLoading.showError(
                        message,
                        duration: const Duration(seconds: 4),
                      );
                      context.read<TransactionBloc>().add(
                            TransactionSetInitial(),
                          );
                    } else if (state.status == TransactionStatus.loading) {
                      EasyLoading.dismiss();
                      EasyLoading.show(
                        status: 'Loading...',
                        dismissOnTap: false,
                        maskType: EasyLoadingMaskType.black,
                      );
                    }
                  },
                  builder: (context, state) {
                    final name = state.name;
                    final email = state.email;
                    final phone = state.phoneNumber;
                    final namaTenda = widget.item.name;
                    final jumlahTenda = state.jumlahTenda;
                    final startDateSend = state.startDateSend;
                    final endDateSend = state.endDateSend;
                    final total = state.totalHarga;

                    return Button.filled(
                      label: "Pilih & Proses Pemesanan",
                      color: AppColors.gradient1,
                      onPressed: () {
                        if (paymentMethod.isEmpty) {
                          EasyLoading.showError(
                              'Pilih metode pembayaran\nterlebih dahulu');

                          return;
                        }

                        final body = TransactionRequestModel(
                          namaPenyewa: name,
                          email: email,
                          noHp: phone,
                          namaTenda: namaTenda,
                          jumlahTenda: jumlahTenda,
                          tanggalMulaiSewa: startDateSend,
                          tanggalSelesaiSewa: endDateSend,
                          totalHarga: total,
                          metodePembayaran: paymentMethod,
                        );

                        context.read<TransactionBloc>().add(
                              TransactionCreateDataRent(
                                body: body,
                              ),
                            );
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
