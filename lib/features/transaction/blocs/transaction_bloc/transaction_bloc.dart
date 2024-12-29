import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/datasources/transaction_remote_datasource.dart';
import '../../../../data/models/request/transaction_request_model.dart';
import '../../../../data/models/response/error_response_model.dart';
import '../../../../data/models/response/success_response_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRemoteDatasource transactionRemoteDatasource;

  TransactionBloc({
    required this.transactionRemoteDatasource,
  }) : super(const TransactionState()) {
    on<TransactionCreateDataRent>(_onTransactionCreateDataRent);
    on<TransactionUpdateDataRent>(_onTransactionUpdateDataRent);

    on<TransactionSetInitial>(_onTransactionSetInitial);
    on<TransactionSetUpdateInitial>(_onTransactionSetUpdateInitial);
    on<TransactionSetAllFieldInitial>(_onTransactionSetAllFieldInitial);

    on<TransactionInputName>(_onTransactionInputName);
    on<TransactionInputEmail>(_onTransactionInputEmail);
    on<TransactionInputPhoneNumber>(_onTransactionInputPhoneNumber);
    on<TransactionInputNamaTenda>(_onTransactionInputNamaTenda);
    on<TransactionInputJumlahTenda>(_onTransactionInputJumlahTenda);
    on<TransactionInputTanggalMulai>(_onTransactionInputTanggalMulai);
    on<TransactionInputTanggalSelesai>(_onTransactionInputTanggalSelesai);
    on<TransactionInputTotalHarga>(_onTransactionInputTotalHarga);
  }

  void _onTransactionSetInitial(
    TransactionSetInitial event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        status: TransactionStatus.initial,
      ),
    );
  }

  void _onTransactionSetUpdateInitial(
    TransactionSetUpdateInitial event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        updateStatus: TransactionUpdateStatus.initial,
      ),
    );
  }

  void _onTransactionSetAllFieldInitial(
    TransactionSetAllFieldInitial event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        status: TransactionStatus.initial,
        name: '',
        email: '',
        phoneNumber: '',
        namaTenda: '',
        jumlahTenda: 0,
        startDateSend: '',
        startDateView: '',
        endDateSend: '',
        endDateView: '',
        totalHarga: 0,
      ),
    );
  }

  Future<void> _onTransactionCreateDataRent(
    TransactionCreateDataRent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(
      state.copyWith(
        status: TransactionStatus.loading,
      ),
    );

    try {
      final response =
          await transactionRemoteDatasource.fetchRequestTransaction(
        body: event.body,
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              status: TransactionStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              status: TransactionStatus.success,
              result: r,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.failure,
          error: ErrorResponseModel(message: e.toString()),
        ),
      );
    }
  }

  Future<void> _onTransactionUpdateDataRent(
    TransactionUpdateDataRent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(
      state.copyWith(
        updateStatus: TransactionUpdateStatus.loading,
      ),
    );

    try {
      final response =
          await transactionRemoteDatasource.fetchUpdateStatusTransaction(
        id: event.id,
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              updateStatus: TransactionUpdateStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              updateStatus: TransactionUpdateStatus.success,
              result: r,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          updateStatus: TransactionUpdateStatus.failure,
          error: ErrorResponseModel(message: e.toString()),
        ),
      );
    }
  }

  void _onTransactionInputName(
    TransactionInputName event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        name: event.value,
      ),
    );
  }

  void _onTransactionInputEmail(
    TransactionInputEmail event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.value,
      ),
    );
  }

  void _onTransactionInputPhoneNumber(
    TransactionInputPhoneNumber event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        phoneNumber: event.value,
      ),
    );
  }

  void _onTransactionInputNamaTenda(
    TransactionInputNamaTenda event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        namaTenda: event.value,
      ),
    );
  }

  void _onTransactionInputJumlahTenda(
    TransactionInputJumlahTenda event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        jumlahTenda: event.value,
      ),
    );
  }

  void _onTransactionInputTanggalMulai(
    TransactionInputTanggalMulai event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        startDateSend: event.valueSend,
        startDateView: event.valueView,
      ),
    );
  }

  void _onTransactionInputTanggalSelesai(
    TransactionInputTanggalSelesai event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        endDateSend: event.valueSend,
        endDateView: event.valueView,
      ),
    );
  }

  void _onTransactionInputTotalHarga(
    TransactionInputTotalHarga event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        totalHarga: event.value,
      ),
    );
  }
}
