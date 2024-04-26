import 'package:cart_app/cart_model.dart';
import 'package:cart_app/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  get badges => null;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My products'),
          centerTitle: true,
          actions: [
            Center(
              child: badges.Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.getCounter().toString(),
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
                child: Icon(Icons.shopping_bag),
              ),
            ),
            const SizedBox(
              width: 8,
            )
          ],
        ),
        body: Column(
          children: [
            FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Image(
                                              height: 100,
                                              width: 100,
                                              image: NetworkImage(snapshot
                                                  .data![index].image
                                                  .toString())),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data![index]
                                                        .productName
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    snapshot.data![index]
                                                            .unitTag
                                                            .toString() +
                                                        "  " +
                                                        r"$" +
                                                        snapshot.data![index]
                                                            .productPrice
                                                            .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ]),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Add to Cart'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }));
                  }
                  return Text('IDK');
                })
          ],
        ),
      ),
    );
  }
}
