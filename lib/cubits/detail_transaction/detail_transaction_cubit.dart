import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';

import 'package:moneytoring/config/constant.dart';
import 'package:moneytoring/models/transaction_detail.dart';
import 'package:moneytoring/repository/repositories.dart';

import '../../models/transaction_model.dart';

part 'detail_transaction_state.dart';

class DetailTransactionCubit extends Cubit<DetailTransactionState> {
  final TransactionRepository transactionRepository;
  DetailTransactionCubit({required this.transactionRepository})
      : super(DetailTransactionState.initial());

  void getTransactionDetails(int transactionId) async {
    emit(state.copyWith(
        detailTransactionStatus: DetailTransactionStatus.loading));
    var db = await openDatabase(databaseApplication);
    List<TransactionDetail> details =
        await transactionRepository.getTransactionDetails(db, transactionId);
    emit(state.copyWith(
        detailTransactionStatus: DetailTransactionStatus.loaded,
        details: details));
  }

  void deleteTransaction(int transactionId) async {
    var db = await openDatabase(databaseApplication);

    emit(state.copyWith(
        detailTransactionStatus: DetailTransactionStatus.loading));

    try {
      await transactionRepository.delete(db, transactionId);

      emit(state.copyWith(
        detailTransactionStatus: DetailTransactionStatus.deleted,
      ));
    } catch (e) {
      emit(state.copyWith(
          detailTransactionStatus: DetailTransactionStatus.error));
    }
  }
}
