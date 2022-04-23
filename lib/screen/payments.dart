import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/wooOrders.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({Key? key}) : super(key: key);
  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  double progress = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<WooOrder>(context).reloadOrder().then(
          (value) => setState(
            () {
              isLoading = false;
            },
          ),
        );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<WooOrder>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Оплата'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    color: Colors.red,
                    backgroundColor: Colors.black,
                  ),
                  Expanded(
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl:
                          'https://sonoff.kz/checkout/order-pay/${order.order[0].id}/?key=${order.order[0].orderKey}&order-pay=${order.order[0].id}',
                      onProgress: (progress) {
                        this.progress = progress / 100;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
