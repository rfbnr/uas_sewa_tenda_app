part of 'transaction_list_bloc.dart';

sealed class TransactionListEvent extends Equatable {
  const TransactionListEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactionByStatusRent extends TransactionListEvent {}

class LoadTransactionByStatusDone extends TransactionListEvent {}
