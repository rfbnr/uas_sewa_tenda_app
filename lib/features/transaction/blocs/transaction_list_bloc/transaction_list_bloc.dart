import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/datasources/transaction_remote_datasource.dart';
import '../../../../data/models/response/error_response_model.dart';
import '../../../../data/models/response/success_response_model.dart';
import '../../../../data/models/response/transaction_response_model.dart';

part 'transaction_list_event.dart';
part 'transaction_list_state.dart';

class TransactionListBloc
    extends Bloc<TransactionListEvent, TransactionListState> {
  final TransactionRemoteDatasource transactionRemoteDatasource;

  TransactionListBloc({
    required this.transactionRemoteDatasource,
  }) : super(TransactionListState()) {
    on<LoadTransactionByStatusRent>(_onLoadTransactionByStatusRent);
    on<LoadTransactionByStatusDone>(_onLoadTransactionByStatusDone);
  }

  Future<void> _onLoadTransactionByStatusRent(
    LoadTransactionByStatusRent event,
    Emitter<TransactionListState> emit,
  ) async {
    emit(
      state.copyWith(
        statusRent: TransactionRentStatus.loading,
      ),
    );

    try {
      final response =
          await transactionRemoteDatasource.fetchGetTransactionByStatus(
        status: "disewa",
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              statusRent: TransactionRentStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              statusRent: TransactionRentStatus.success,
              transactionsRent: r.data,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          statusRent: TransactionRentStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onLoadTransactionByStatusDone(
    LoadTransactionByStatusDone event,
    Emitter<TransactionListState> emit,
  ) async {
    emit(
      state.copyWith(
        statusDone: TransactionDoneStatus.loading,
      ),
    );

    try {
      final response =
          await transactionRemoteDatasource.fetchGetTransactionByStatus(
        status: "dikembalikan",
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              statusDone: TransactionDoneStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              statusDone: TransactionDoneStatus.success,
              transactionsDone: r.data,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          statusDone: TransactionDoneStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
