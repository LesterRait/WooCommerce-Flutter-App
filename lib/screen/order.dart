import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/provider/orders.dart';
import 'package:ecommerce_app/screen/payments.dart';
import 'package:ecommerce_app/widget/app_drawer.dart';
import 'package:ecommerce_app/widget/order_item.dart';

class OrderScreen extends StatelessWidget {
  final apiClient = ApiClient();
  static const routeName = '/orders';
  OrderScreen({Key? key}) : super(key: key);

  final firstName = TextEditingController();
  final secondName = TextEditingController();
  final addressOne = TextEditingController();
  final addressTwo = TextEditingController();
  final city = TextEditingController();
  final country = TextEditingController();
  final postcode = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Заказать',
        ),
      ),
      drawer: const AppDraweWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, i) => OrderItemWidget(
                    order: orderData.orders[0],
                  ),
                ),
              ),
              // Text('$id'),
              SizedBox(
                height: 500,
                child: _textField(),
              ),
              ElevatedButton(
                onPressed: () {
// Create Order - POST

                  Future<void> createOrder() async {
                    final orders = await apiClient.createOrder(
                      firstName: firstName.text,
                      lastName: secondName.text,
                      addressOne: addressOne.text,
                      addressTwo: addressTwo.text,
                      city: city.text,
                      country: country.text,
                      email: email.text,
                      phone: phone.text,
                      postcode: postcode.text,
                      state: 'kz',
                      total: '1000',
                      payment_method_title: 'Банковская карта Visa/Mastercard',
                      payment_method: 'cp',
                      quantity: orderData.orders[0].products[0].quantity,
                      product_id: orderData.orders[0].products[0].id,
                    );
                  }

                  createOrder();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PaymentsScreen()));
                },
                child: const Text('Подтвердить'),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

// TextFiel - Create Order

  Column _textField() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: firstName,
                decoration: const InputDecoration(
                  labelText: 'Имя',
                  // hintText: 'Турар',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: TextField(
                controller: secondName,
                decoration: const InputDecoration(
                  labelText: 'Фамилия',
                  // hintText: 'Тураров',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Flexible(
          child: TextField(
            controller: addressOne,
            decoration: const InputDecoration(
              labelText: 'Адрес',
              // hintText: 'Досмухамедова 2В',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Flexible(
          child: TextField(
            controller: addressTwo,
            decoration: const InputDecoration(
              labelText: 'Крыло, подьезд, этаж и т.д (необязательно)',
              // hintText: '4 подьезд, 2 этаж, 32 квартира',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: city,
                decoration: const InputDecoration(
                  labelText: 'Город',
                  // hintText: 'Алматы',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: TextField(
                controller: country,
                decoration: const InputDecoration(
                  labelText: 'Область / Район',
                  // hintText: 'Алмалинский',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Flexible(
          child: TextField(
            controller: postcode,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Почтовый индекс',
              // hintText: '050000',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Flexible(
          child: TextField(
            controller: phone,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Телефон',
              prefixText: '+ 7',
              // hintText: '123-456-78-90',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Flexible(
          child: TextField(
            controller: email,
            decoration: const InputDecoration(
              labelText: 'Email',
              // hintText: 'admin@sonoff.kz',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
