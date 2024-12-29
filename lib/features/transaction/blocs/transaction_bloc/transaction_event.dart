part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionCreateDataRent extends TransactionEvent {
  final TransactionRequestModel body;

  const TransactionCreateDataRent({
    required this.body,
  });

  @override
  List<Object> get props => [
        body,
      ];
}

class TransactionUpdateDataRent extends TransactionEvent {
  final int id;

  const TransactionUpdateDataRent({
    required this.id,
  });

  @override
  List<Object> get props => [
        id,
      ];
}

class TransactionSetInitial extends TransactionEvent {}

class TransactionSetUpdateInitial extends TransactionEvent {}

class TransactionSetAllFieldInitial extends TransactionEvent {}

class TransactionInputName extends TransactionEvent {
  final String value;

  const TransactionInputName({
    required this.value,
  });

  @override
  List<Object> get props => [
        value,
      ];
}

class TransactionInputEmail extends TransactionEvent {
  final String value;

  const TransactionInputEmail({
    required this.value,
  });

  @override
  List<Object> get props => [
        value,
      ];
}

class TransactionInputPhoneNumber extends TransactionEvent {
  final String value;

  const TransactionInputPhoneNumber({
    required this.value,
  });

  @override
  List<Object> get props => [
        value,
      ];
}

class TransactionInputNamaTenda extends TransactionEvent {
  final String value;

  const TransactionInputNamaTenda({
    required this.value,
  });

  @override
  List<Object> get props => [
        value,
      ];
}

class TransactionInputJumlahTenda extends TransactionEvent {
  final int value;

  const TransactionInputJumlahTenda({
    required this.value,
  });

  @override
  List<Object> get props => [
        value,
      ];
}

class TransactionInputTanggalMulai extends TransactionEvent {
  final String valueSend;
  final String valueView;

  const TransactionInputTanggalMulai({
    required this.valueSend,
    required this.valueView,
  });

  @override
  List<Object> get props => [
        valueSend,
        valueView,
      ];
}

class TransactionInputTanggalSelesai extends TransactionEvent {
  final String valueSend;
  final String valueView;

  const TransactionInputTanggalSelesai({
    required this.valueSend,
    required this.valueView,
  });

  @override
  List<Object> get props => [
        valueSend,
        valueView,
      ];
}

class TransactionInputTotalHarga extends TransactionEvent {
  final int value;

  const TransactionInputTotalHarga({
    required this.value,
  });

  @override
  List<Object> get props => [
        value,
      ];
}
