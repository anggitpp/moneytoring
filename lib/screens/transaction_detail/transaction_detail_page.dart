import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/config/constant.dart';
import 'package:moneytoring/config/theme.dart';
import 'package:moneytoring/screens/transaction_detail/widgets/order_information_item.dart';
import 'package:moneytoring/screens/transaction_detail/widgets/transaction_detail_item.dart';
import 'package:moneytoring/widgets/header_page.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            HeaderPage(
              Icon(Icons.arrow_back, size: 24),
              Text(
                'Transaction Details',
                style: AppTextStyle.veryLargeText.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 24,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction Item',
                    style: AppTextStyle.mediumText,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      3,
                      (index) => Column(
                        children: [
                          TransactionDetailItem(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Order Information',
                    style: AppTextStyle.mediumText,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  OrderInformationItem(
                    title: 'Product',
                    information: Text(
                      NumberFormat.currency(
                              locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
                          .format(450000),
                      style: AppTextStyle.mediumText,
                    ),
                  ),
                  OrderInformationItem(
                    title: 'Date',
                    information: Text(
                      'Wed, 2/12/2020',
                      style: AppTextStyle.mediumText,
                    ),
                  ),
                  OrderInformationItem(
                    title: 'User',
                    information: SizedBox(
                      height: 25,
                      child: TextField(
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
                    title: 'Fee',
                    information: SizedBox(
                      height: 25,
                      child: TextField(
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
                    title: 'Product',
                    information: Text(
                      NumberFormat.currency(
                              locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
                          .format(450000),
                      style: AppTextStyle.mediumText,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: AppSizes.phoneWidthMargin(context),
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.yellowColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Save Transaction',
                          style: AppTextStyle.mediumText,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
