part of 'transaction_bloc.dart';

enum TransactionStatus { initial, loading, success, failure }

enum TransactionUpdateStatus { initial, loading, success, failure }

class TransactionState extends Equatable {
  final TransactionStatus? status;
  final TransactionUpdateStatus? updateStatus;
  final ErrorResponseModel? error;
  final SuccessResponseModel? result;
  final String name;
  final String email;
  final String phoneNumber;
  final String namaTenda;
  final int jumlahTenda;
  final String startDateSend;
  final String startDateView;
  final String endDateSend;
  final String endDateView;
  final int totalHarga;

  const TransactionState({
    this.status = TransactionStatus.initial,
    this.updateStatus = TransactionUpdateStatus.initial,
    this.error,
    this.result,
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.namaTenda = '',
    this.jumlahTenda = 0,
    this.startDateSend = '',
    this.startDateView = '',
    this.endDateSend = '',
    this.endDateView = '',
    this.totalHarga = 0,
  });

  TransactionState copyWith({
    TransactionStatus? status,
    TransactionUpdateStatus? updateStatus,
    ErrorResponseModel? error,
    SuccessResponseModel? result,
    String? name,
    String? email,
    String? phoneNumber,
    String? namaTenda,
    int? jumlahTenda,
    String? startDateSend,
    String? startDateView,
    String? endDateSend,
    String? endDateView,
    int? totalHarga,
  }) {
    return TransactionState(
      status: status ?? this.status,
      updateStatus: updateStatus ?? this.updateStatus,
      error: error ?? this.error,
      result: result ?? this.result,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      namaTenda: namaTenda ?? this.namaTenda,
      jumlahTenda: jumlahTenda ?? this.jumlahTenda,
      startDateSend: startDateSend ?? this.startDateSend,
      startDateView: startDateView ?? this.startDateView,
      endDateSend: endDateSend ?? this.endDateSend,
      endDateView: endDateView ?? this.endDateView,
      totalHarga: totalHarga ?? this.totalHarga,
    );
  }

  @override
  List<Object?> get props => [
        status,
        updateStatus,
        error,
        result,
        name,
        email,
        phoneNumber,
        namaTenda,
        jumlahTenda,
        startDateSend,
        startDateView,
        endDateSend,
        endDateView,
        totalHarga,
      ];
}
