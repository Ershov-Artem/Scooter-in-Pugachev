import 'package:flutter/material.dart';

import 'package:pay/pay.dart';

class PayForm extends StatefulWidget {
  //const PayForm({ Key? key }) : super(key: key);

  @override
  _PayFormState createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  int deposit = 500;
  int price = 7;

  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '500',
      status: PaymentItemStatus.final_price,
    )
  ];
  Pay _payClient = Pay.withAssets(['gpay.json', 'applepay.json']);
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.electric_scooter_rounded,
              color: Theme.of(context).primaryColor,
              size: 100,
            ),
            Container(
                padding: EdgeInsets.only(bottom: 60, top: 60),
                width: 275,
                child: Text(
                  "На время поездки с Вас спишется залог $deposit рублей, который вернется по окончании поездки. Каждая минута поездки будет стоить $price рублей.",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                )),
            // ApplePayButton(
            //   paymentConfigurationAsset: 'applepay.json',
            //   paymentItems: _paymentItems,
            //   height: 75,
            //   width: 275,
            //   style: ApplePayButtonStyle.black,
            //   type: ApplePayButtonType.buy,
            //   margin: const EdgeInsets.only(top: 15.0),
            //   onPaymentResult: (data) {
            //     print(data);
            //   },
            //   loadingIndicator: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // ),
            GooglePayButton(
              height: 75,
              width: 275,
              paymentConfigurationAsset: 'gpay.json',
              paymentItems: _paymentItems,
              style: GooglePayButtonStyle.black,
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: (data) {
                print(data);
              },
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
              onPressed: onGooglePayPressed,
            ),
          ],
        ));
  }

  void onGooglePayPressed() async {
    final result = await _payClient.showPaymentSelector(
        provider: PayProvider.google_pay, paymentItems: _paymentItems);
  }
}
