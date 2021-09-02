import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pay/pay.dart';
import 'package:scooter_pugachev/pages/pay/request/entities/entities.dart';
import 'package:scooter_pugachev/pages/reg&confirm/register/widgets/regButton.dart';
import '../request/cubit/cubit.dart';
import 'package:scooter_pugachev/pages/timer/timer.dart';

class PayForm extends StatefulWidget {
  @override
  _PayFormState createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  int deposit = 500;
  int price = 7;
  PayBloc _bloc;
  PayResponse _response;

  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '500',
      status: PaymentItemStatus.final_price,
    )
  ];
  Pay _payClient = Pay.withAssets(['gpay.json', 'applepay.json']);

  @override
  void didChangeDependencies() async {
    _bloc = BlocProvider.of<PayBloc>(context);
    super.didChangeDependencies();
  }

  void onGooglePayResult(paymentResult) async {
    print("inside ogpr");
    print(paymentResult.toString());
    print("something goes");
    // final result = await _payClient.showPaymentSelector(
    //     provider: PayProvider.google_pay, paymentItems: _paymentItems);
    // print("result: $result");
    _response = await _bloc.postPayToken(
        paymentResult['paymentMethodData']['tokenizationData']['token'], 0);
    print("request goes");
  }

  @override
  Widget build(BuildContext context) => BlocConsumer(
      bloc: _bloc,
      listener: (context, state) async {},
      builder: (context, state) {
        if (state == PayStatus.initial) {
          print("on GPay");
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
                    onPaymentResult: onGooglePayResult,
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    //onPressed: onGooglePayPressed,
                  ),
                ],
              ));
        } else if (state == PayStatus.loading) {
          return Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Подождите, загрузка",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Color(0xff8ebbff),
                  )
                ],
              ));
        } else if (state == PayStatus.ok) {
          print("all ok, I can't believe");
          return TimerPage(null);
        } else {
          print("error with pay: ${_response.error}");
          return Align(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Произошла ошибка ${_response.error}"),
                    RegButton(
                        onTap: () {},
                        height: 55,
                        width: 230,
                        text: "Попробовать снова",
                        decoration: BoxDecoration(
                            color: Color(0xff8ebbff),
                            borderRadius: BorderRadius.circular(10)))
                  ]));
        }
      });
}
