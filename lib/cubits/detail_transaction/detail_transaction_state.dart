part of 'detail_transaction_cubit.dart';

enum DetailTransactionStatus {
  initial,
  loading,
  loaded,

  deleted,
  error,
}

class DetailTransactionState extends Equatable {
  final DetailTransactionStatus detailTransactionStatus;
  final List<TransactionDetail> details;
  const DetailTransactionState({
    required this.detailTransactionStatus,
    required this.details,
  });

  factory DetailTransactionState.initial() {
    return const DetailTransactionState(
        detailTransactionStatus: DetailTransactionStatus.initial, details: []);
  }

  DetailTransactionState copyWith({
    DetailTransactionStatus? detailTransactionStatus,
    List<TransactionDetail>? details,
  }) {
    return DetailTransactionState(
      detailTransactionStatus:
          detailTransactionStatus ?? this.detailTransactionStatus,
      details: details ?? this.details,
    );
  }

  @override
  String toString() =>
      'DetailTransactionState(detailTransactionStatus: $detailTransactionStatus, details: $details)';

  @override
  List<Object> get props => [detailTransactionStatus, details];
}
