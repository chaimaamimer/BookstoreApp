import 'package:flutter/material.dart';
import 'package:bazar_app/bookdetails_page.dart'; 

class PaymentDetailsPage extends StatelessWidget {
  final List<Book> cartItems;
  final double shipping;

  const PaymentDetailsPage({
    super.key,
    required this.cartItems,
    required this.shipping,
  });

  double get totalPrice =>
      cartItems.fold(0, (sum, book) => sum + (book.price * book.quantity));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Center(child: const Text("Payment Details", style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold),)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Prix total 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Price",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("\$${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            //Liste des livres 
            ...cartItems.map((book) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(book.title)),
                      Text(
                          "\$${(book.price * book.quantity).toStringAsFixed(2)}"),
                    ],
                  ),
                )),
            const Divider(height: 30),
            //Shipping 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Shipping",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("\$${shipping.toStringAsFixed(2)}"),
              ],
            ),
            const SizedBox(height: 10),
            //Total Payment
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Payment",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                  "\$${(totalPrice + shipping).toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
