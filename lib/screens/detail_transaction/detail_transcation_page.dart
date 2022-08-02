import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneytoring/config/helper.dart';
import 'package:moneytoring/config/route_name.dart';
import 'package:moneytoring/cubits/cubits.dart';
import 'package:moneytoring/models/transaction_item.dart';
import 'package:moneytoring/models/transaction_model.dart';
import 'package:moneytoring/widgets/alert_dialog.dart';

import '../../config/constant.dart';
import '../../config/theme.dart';
import '../../widgets/header_page.dart';
import '../transaction_detail/widgets/order_information_item.dart';
import '../transaction_detail/widgets/transaction_detail_item.dart';

class DetailTransactionPage extends StatefulWidget {
  final Map arguments;

  const DetailTransactionPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<DetailTransactionPage> createState() => _DetailTransactionPageState();
}

class _DetailTransactionPageState extends State<DetailTransactionPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<DetailTransactionCubit>()
        .getTransactionDetails(widget.arguments['transaction'].id);
  }

  @override
  Widget build(BuildContext context) {
    TransactionModel transaction = widget.arguments['transaction'];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: BlocConsumer<DetailTransactionCubit, DetailTransactionState>(
            listener: (context, state) {
              if (state.detailTransactionStatus ==
                  DetailTransactionStatus.deleted) {
                Navigator.pushReplacementNamed(context, RouteName.main);
              }
            },
            builder: (context, state) {
              return state.detailTransactionStatus !=
                      DetailTransactionStatus.loading
                  ? Column(
                      children: [
                        HeaderPage(
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.arrow_back, size: 24)),
                          Text(
                            'Transaction Details',
                            style: AppTextStyle.veryLargeText.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          GestureDetector(
                              onTap: () => showGlobalAlertConfirm(
                                  context,
                                  'Delete Transactions',
                                  'Are you sure to delete this transaction?\n',
                                  () => context
                                      .read<DetailTransactionCubit>()
                                      .deleteTransaction(
                                          widget.arguments['transaction'].id)),
                              child: const Icon(Icons.delete)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.defaultMargin),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transaction Item',
                                style: AppTextStyle.mediumText,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: state.details
                                      .map(
                                        (e) => TransactionDetailItem(
                                          TransactionItem(
                                            id: e.id,
                                            product: e.product,
                                            amount: int.parse(e.quantity),
                                            sellingPrice:
                                                e.product.sellingPrice,
                                          ),
                                        ),
                                      )
                                      .toList()),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                'Order Information',
                                style: AppTextStyle.mediumText,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              OrderInformationItem(
                                title: 'Product',
                                information: Text(
                                  Helper.getFormattedCurrency(state.details
                                      .map((e) =>
                                          e.product.sellingPrice *
                                          num.parse(e.quantity))
                                      .reduce((a, b) => a + b)),
                                  style: AppTextStyle.mediumText,
                                ),
                              ),
                              OrderInformationItem(
                                title: 'Date',
                                information: Text(
                                  Helper.getFormattedDate(
                                      transaction.transactionDate),
                                  style: AppTextStyle.mediumText,
                                ),
                              ),
                              OrderInformationItem(
                                title: 'Buyer Name',
                                information: Text(
                                  transaction.buyerName,
                                  style: AppTextStyle.mediumText,
                                ),
                              ),
                              OrderInformationItem(
                                title: 'Discount',
                                information: Text(
                                  Helper.getFormattedCurrency(
                                      transaction.discount),
                                  style: AppTextStyle.mediumText,
                                ),
                              ),
                              OrderInformationItem(
                                title: 'Fee',
                                information: Text(
                                  Helper.getFormattedCurrency(transaction.fee),
                                  style: AppTextStyle.mediumText,
                                ),
                              ),
                              OrderInformationItem(
                                title: 'Total',
                                information: Text(
                                  Helper.getFormattedCurrency(
                                      transaction.totalPrice),
                                  style: AppTextStyle.mediumText,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: AppSizes.phoneWidthMargin(context),
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushNamed(
                                context, RouteName.transaction,
                                arguments: {
                                  'transaction': transaction,
                                  'details': state.details,
                                }),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.yellowColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Edit Transaction',
                              style: AppTextStyle.mediumText,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
