part of 'transaction_list_bloc.dart';

enum TransactionRentStatus { initial, loading, success, failure }

enum TransactionDoneStatus { initial, loading, success, failure }

class TransactionListState extends Equatable {
  final TransactionRentStatus? statusRent;
  final TransactionDoneStatus? statusDone;
  final List<TransactionResultResponseModel>? transactionsRent;
  final List<TransactionResultResponseModel>? transactionsDone;
  final ErrorResponseModel? error;
  final SuccessResponseModel? result;

  const TransactionListState({
    this.statusRent = TransactionRentStatus.initial,
    this.statusDone = TransactionDoneStatus.initial,
    this.transactionsRent = const <TransactionResultResponseModel>[],
    this.transactionsDone = const <TransactionResultResponseModel>[],
    this.error,
    this.result,
  });

  TransactionListState copyWith({
    TransactionRentStatus? statusRent,
    TransactionDoneStatus? statusDone,
    List<TransactionResultResponseModel>? transactionsRent,
    List<TransactionResultResponseModel>? transactionsDone,
    ErrorResponseModel? error,
    SuccessResponseModel? result,
  }) {
    return TransactionListState(
      statusRent: statusRent ?? this.statusRent,
      statusDone: statusDone ?? this.statusDone,
      transactionsRent: transactionsRent ?? this.transactionsRent,
      transactionsDone: transactionsDone ?? this.transactionsDone,
      error: error ?? this.error,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
        statusRent,
        statusDone,
        transactionsRent,
        transactionsDone,
        error,
        result,
      ];
}
