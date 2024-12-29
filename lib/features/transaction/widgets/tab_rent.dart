import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/spaces.dart';
import '../blocs/transaction_bloc/transaction_bloc.dart';
import '../blocs/transaction_list_bloc/transaction_list_bloc.dart';
import 'transaction_card_item_widget.dart';

class TabRent extends StatefulWidget {
  const TabRent({super.key});

  @override
  State<TabRent> createState() => _TabRentState();
}

class _TabRentState extends State<TabRent> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionListBloc>().add(
          LoadTransactionByStatusRent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SpaceHeight(30),
          BlocBuilder<TransactionListBloc, TransactionListState>(
            builder: (context, state) {
              switch (state.statusRent) {
                case TransactionRentStatus.loading:
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                case TransactionRentStatus.failure:
                  final message = state.error?.message ?? "An error occurred";

                  return Center(
                    child: Text(message),
                  );

                case TransactionRentStatus.success:
                  final data = state.transactionsRent;

                  return data?.isEmpty ?? true
                      ? const Center(
                          child: Text("No data found"),
                        )
                      : ListView.builder(
                          itemCount: data?.length ?? 0,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final item = data![index];

                            return TransactionCardItemWidget(
                              data: item,
                              onPressed: () {
                                context.read<TransactionBloc>().add(
                                      TransactionUpdateDataRent(
                                        id: item.id ?? 0,
                                      ),
                                    );
                              },
                            );
                          },
                        );

                default:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
