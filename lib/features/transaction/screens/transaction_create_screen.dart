import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:uas_sewa_tenda_app/core/extension/int_currency_ext.dart';
import 'package:uas_sewa_tenda_app/core/extension/string_currency_ext.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field_widget.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/datas.dart';
import '../blocs/transaction_bloc/transaction_bloc.dart';
import 'transaction_payment_screen.dart';

class TransactionCreateScreen extends StatefulWidget {
  const TransactionCreateScreen({
    super.key,
    required this.item,
  });

  final TendaItemModel item;

  @override
  State<TransactionCreateScreen> createState() =>
      _TransactionCreateScreenState();
}

class _TransactionCreateScreenState extends State<TransactionCreateScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(
          TransactionSetAllFieldInitial(),
        );
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final jumlahTendaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isi Data Penyewaan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              label: "Nama Penyewa",
              controller: nameController,
              fillColor: AppColors.white,
              prefixIcon: Icon(
                Icons.person,
                color: AppColors.gradient2,
              ),
              onChanged: (value) {
                context.read<TransactionBloc>().add(
                      TransactionInputName(
                        value: value,
                      ),
                    );
              },
            ),
            SpaceHeight(20),
            CustomTextField(
              label: "Email Penyewa",
              controller: emailController,
              fillColor: AppColors.white,
              prefixIcon: Icon(
                Icons.email,
                color: AppColors.gradient2,
              ),
              onChanged: (value) {
                context.read<TransactionBloc>().add(
                      TransactionInputEmail(
                        value: value,
                      ),
                    );
              },
            ),
            SpaceHeight(20),
            CustomTextField(
              label: "Nomor Telepon",
              controller: phoneController,
              fillColor: AppColors.white,
              keyboardType: TextInputType.number,
              prefixIcon: Icon(
                Icons.phone,
                color: AppColors.gradient2,
              ),
              onChanged: (value) {
                context.read<TransactionBloc>().add(
                      TransactionInputPhoneNumber(
                        value: value,
                      ),
                    );
              },
            ),
            SpaceHeight(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Nama Tenda",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SpaceHeight(12.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey[400]!,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.cabin,
                        size: 20,
                        color: AppColors.gradient2,
                      ),
                      const SpaceWidth(10),
                      Text(
                        widget.item.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SpaceHeight(20),
            CustomTextField(
              label: "Jumlah Tenda",
              controller: jumlahTendaController,
              fillColor: AppColors.white,
              keyboardType: TextInputType.number,
              prefixIcon: Icon(
                Icons.format_list_numbered_rounded,
                color: AppColors.gradient2,
              ),
              onChanged: (value) {
                context.read<TransactionBloc>().add(
                      TransactionInputJumlahTenda(
                        value: value.toIntegerFromText,
                      ),
                    );

                context.read<TransactionBloc>().add(
                      TransactionInputTotalHarga(
                        value: value.toIntegerFromText * widget.item.price,
                      ),
                    );
              },
            ),
            SpaceHeight(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tanggal mulai disewa",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SpaceHeight(12.0),
                InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    ).then(
                      (value) {
                        String formattedDateSend =
                            DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(value!);
                        String formattedDateView =
                            DateFormat('dd MMMM yyyy').format(value);

                        context.read<TransactionBloc>().add(
                              TransactionInputTanggalMulai(
                                valueSend: formattedDateSend,
                                valueView: formattedDateView,
                              ),
                            );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey[400]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.today,
                          size: 20,
                          color: AppColors.gradient2,
                        ),
                        const SpaceWidth(10),
                        BlocBuilder<TransactionBloc, TransactionState>(
                          builder: (context, state) {
                            final startDate = state.startDateView;

                            return Text(
                              startDate.isEmpty
                                  ? 'Tanggal mulai disewa'
                                  : startDate,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SpaceHeight(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tanggal selesai disewa",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SpaceHeight(12.0),
                InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    ).then(
                      (value) {
                        String formattedDateSend =
                            DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(value!);
                        String formattedDateView =
                            DateFormat('dd MMMM yyyy').format(value);

                        context.read<TransactionBloc>().add(
                              TransactionInputTanggalSelesai(
                                valueSend: formattedDateSend,
                                valueView: formattedDateView,
                              ),
                            );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey[400]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.event,
                          size: 20,
                          color: AppColors.gradient2,
                        ),
                        const SpaceWidth(10),
                        BlocBuilder<TransactionBloc, TransactionState>(
                          builder: (context, state) {
                            final endDate = state.endDateView;

                            return Text(
                              endDate.isEmpty
                                  ? 'Tanggal selesai disewa'
                                  : endDate,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SpaceHeight(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Harga",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SpaceHeight(12.0),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey[400]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          size: 20,
                          color: AppColors.gradient2,
                        ),
                        const SpaceWidth(10),
                        BlocBuilder<TransactionBloc, TransactionState>(
                          builder: (context, state) {
                            final price = state.totalHarga.currencyFormatRp;

                            return Text(
                              price.isEmpty ? 'Rp 0' : price,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SpaceHeight(50),
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                final name = state.name;
                final email = state.email;
                final phoneNumber = state.phoneNumber;
                // final namaTenda = widget.item.name;
                final jumlahTenda = state.jumlahTenda;
                final startDateSend = state.startDateSend;
                final endDateSend = state.endDateSend;
                final totalHarga = state.totalHarga;

                return Button.filled(
                  color: AppColors.gradient1,
                  label: "Lanjut Pembayaran",
                  onPressed: () {
                    if (name.isEmpty ||
                        email.isEmpty ||
                        phoneNumber.isEmpty ||
                        jumlahTenda == 0 ||
                        startDateSend.isEmpty ||
                        endDateSend.isEmpty ||
                        totalHarga == 0) {
                      EasyLoading.showError("Data tidak boleh kosong");
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionPaymentScreen(
                          item: widget.item,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SpaceHeight(50),
          ],
        ),
      ),
    );
  }
}
