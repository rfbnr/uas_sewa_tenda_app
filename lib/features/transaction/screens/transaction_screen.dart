import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/constants/colors.dart';
import '../../../data/datasources/transaction_remote_datasource.dart';
import '../blocs/transaction_bloc/transaction_bloc.dart';
import '../blocs/transaction_list_bloc/transaction_list_bloc.dart';
import '../widgets/tab_complete.dart';
import '../widgets/tab_rent.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionListBloc(
        transactionRemoteDatasource: TransactionRemoteDatasource(),
      ),
      child: const TransactionScreenView(),
    );
  }
}

class TransactionScreenView extends StatelessWidget {
  const TransactionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state.updateStatus == TransactionUpdateStatus.loading) {
          EasyLoading.dismiss();
          EasyLoading.show(
            status: "loading kirim data...",
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          Navigator.pop(context);
        } else if (state.updateStatus == TransactionUpdateStatus.failure) {
          final message = state.error?.message ?? "Error";

          EasyLoading.dismiss();
          EasyLoading.showError(
            message,
            duration: const Duration(seconds: 4),
          );

          context.read<TransactionBloc>().add(
                TransactionSetUpdateInitial(),
              );
        } else if (state.updateStatus == TransactionUpdateStatus.success) {
          final message = state.result?.message ?? "Success";

          EasyLoading.dismiss();
          EasyLoading.showSuccess(message);

          context.read<TransactionBloc>().add(
                TransactionSetUpdateInitial(),
              );

          context.read<TransactionListBloc>().add(
                LoadTransactionByStatusRent(),
              );
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Transactions',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.gradient1,
            bottom: TabBar(
              dividerColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text(
                    'Sedang disewa',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Sudah dikembalikan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TabRent(),
              TabComplete(),
            ],
          ),
        ),
      ),
    );
  }
}
