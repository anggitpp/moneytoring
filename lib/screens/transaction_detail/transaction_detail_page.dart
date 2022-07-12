import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/config/constant.dart';
import 'package:moneytoring/config/theme.dart';
import 'package:moneytoring/screens/transaction_detail/widgets/order_information_item.dart';
import 'package:moneytoring/screens/transaction_detail/widgets/transaction_detail_item.dart';
import 'package:moneytoring/widgets/header_page.dart';

import '../../config/route_name.dart';
import '../../cubits/cubits.dart';

class TransactionDetailPage extends StatefulWidget {
  const TransactionDetailPage({Key? key}) : super(key: key);

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  final TextEditingController _feeController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _buyerController = TextEditingController();

  final now = DateTime.now();
  final formatter = DateFormat('E dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: BlocConsumer<TransactionCubit, TransactionState>(
          listener: (context, state) {
            if (state.transactionStatus == TransactionStatus.finish) {
              Navigator.pushReplacementNamed(context, RouteName.main);
            }
          },
          builder: (context, state) {
            final totalPrice = state.transactionItems
                .map((element) => element.product.sellingPrice * element.amount)
                .reduce((a, b) => a + b);
            final totalAmount = state.transactionItems
                .map((element) => element.amount)
                .reduce((a, b) => a + b);
            return ListView(
              padding: EdgeInsets.zero,
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
                  const SizedBox(
                    width: 24,
                  ),
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
                          children: state.transactionItems
                              .map(
                                (e) => TransactionDetailItem(e),
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
                          NumberFormat.currency(
                                  locale: 'id_ID',
                                  symbol: 'IDR ',
                                  decimalDigits: 0)
                              .format(totalPrice),
                          style: AppTextStyle.mediumText,
                        ),
                      ),
                      OrderInformationItem(
                        title: 'Date',
                        information: Text(
                          formatter.format(now),
                          style: AppTextStyle.mediumText,
                        ),
                      ),
                      OrderInformationItem(
                        title: 'User',
                        information: SizedBox(
                          height: 25,
                          child: TextField(
                            controller: _buyerController,
                            textAlign: TextAlign.end,
                            style: AppTextStyle.mediumText,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.lightGreyColor,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.yellowColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      OrderInformationItem(
                        title: 'Discount',
                        information: SizedBox(
                          height: 25,
                          child: TextField(
                            controller: _discountController,
                            textAlign: TextAlign.end,
                            style: AppTextStyle.mediumText,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.lightGreyColor,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.yellowColor),
                              ),
                            ),
                            onChanged: (value) =>
                                context.read<TransactionCubit>().getTotalPrice(
                                      _discountController.text,
                                      _feeController.text,
                                    ),
                          ),
                        ),
                      ),
                      OrderInformationItem(
                        title: 'Fee',
                        information: SizedBox(
                          height: 25,
                          child: TextField(
                            controller: _feeController,
                            textAlign: TextAlign.end,
                            style: AppTextStyle.mediumText,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.lightGreyColor,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.yellowColor),
                              ),
                            ),
                            onChanged: (value) =>
                                context.read<TransactionCubit>().getTotalPrice(
                                      _discountController.text,
                                      _feeController.text,
                                    ),
                          ),
                        ),
                      ),
                      OrderInformationItem(
                        title: 'Total',
                        information: Text(
                          NumberFormat.currency(
                                  locale: 'id_ID',
                                  symbol: 'IDR ',
                                  decimalDigits: 0)
                              .format(state.totalPrice == 0
                                  ? totalPrice
                                  : state.totalPrice),
                          style: AppTextStyle.mediumText,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: AppSizes.phoneWidthMargin(context),
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () => context
                              .read<TransactionCubit>()
                              .insertTransaction({
                            'buyer_name': _buyerController.text,
                            'fee': _feeController.text.isNotEmpty
                                ? double.parse(_feeController.text)
                                : 0,
                            'category_type': 'income',
                            'discount': _discountController.text.isNotEmpty
                                ? double.parse(_discountController.text)
                                : 0,
                            'transaction_date':
                                now.microsecondsSinceEpoch.toString(),
                            'total': totalPrice,
                            'quantity': totalAmount,
                          }, state.transactionItems),
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.yellowColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Save Transaction',
                            style: AppTextStyle.mediumText,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
