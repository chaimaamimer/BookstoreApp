import 'package:bazar_app/bookdetails_page.dart';
import 'package:bazar_app/cart_class.dart';
import 'package:bazar_app/choose_delivery_page.dart';
import 'package:bazar_app/choose_payment_card.dart';
import 'package:bazar_app/payment_details_page.dart';
import 'package:flutter/material.dart';
import 'package:bazar_app/theme/app_colors.dart';

class ConfirmorderPage extends StatefulWidget {
  const ConfirmorderPage({super.key});

  @override
  State<ConfirmorderPage> createState() => _ConfirmorderPageState();
}

class _ConfirmorderPageState extends State<ConfirmorderPage> {
  String? selectedPayment;
  String? selectedDateTime;

  double get shippingCost => 2.0;

  double get totalPayment => Cart.getTotalPrice() + shippingCost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Confirm Order',
          style: TextStyle(
              fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.grey[900]),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppColors.grey[900]),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Adresse
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Address",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on,
                          color: AppColors.primary[500], size: 28),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Utama Street No.20",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.grey[900])),
                            const SizedBox(height: 4),
                            Text(
                              "Dumbo Street No.20, Dumbo, New York 10001, United States",
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 16, color: AppColors.grey[600]),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 100,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary[500],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text("Change",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Résumé
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Summary",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  _buildSummaryRow("Price",
                      "\$${Cart.getTotalPrice().toStringAsFixed(2)}"),
                  _buildSummaryRow(
                      "Shipping", "\$${shippingCost.toStringAsFixed(2)}"),
                  const Divider(),
                  _buildSummaryRow(
                    "Total Payment",
                    "\$${totalPayment.toStringAsFixed(2)}",
                    isBold: true,
                    color: AppColors.grey[900],
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentDetailsPage(
                          cartItems: Cart.items,
                          shipping: shippingCost,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      const Text("See Details",style: TextStyle(fontFamily: 'Roboto',fontWeight:FontWeight.bold),),
                      Icon(Icons.arrow_right, color: AppColors.primary[500]),
                    ],
                  ),
                ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Date & Temps
           _buildCard(
  child: ListTile(
    leading: Icon(Icons.calendar_today, color: AppColors.primary[500]),
    title: const Text("Date & time",
        style: TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(
      selectedDateTime ?? "Choose date and time",
      style: TextStyle(color: AppColors.grey[600]),
    ),
    trailing: Icon(Icons.arrow_forward_ios,
        size: 16, color: AppColors.grey[600]),
    onTap: () async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChooseDeliveryPage()),
      );
      if (result != null) {
        setState(() {
          selectedDateTime =
              "${result["date"]} at ${result["time"]}";
        });
      }
    },
  ),
),


            const SizedBox(height: 16),
            // Paiement
            _buildCard(
  child: ListTile(
    leading: Icon(Icons.credit_card, color: AppColors.primary[500]),
    title: const Text("Payment",
        style: TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(
      selectedPayment ?? "Choose your payment",
      style: TextStyle(color: AppColors.grey[600]),
    ),
    trailing: Icon(Icons.arrow_forward_ios,
        size: 16, color: AppColors.grey[600]),
    onTap: () async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChoosePaymentCard()),
      );
      if (result != null) {
        setState(() {
          selectedPayment = result;
        });
      }
    },
  ),
),
          ],
        ),
      ),
      // Bouton Commander
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Order confirmed ")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary[500],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            child: const Text("Order",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey[200]!),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: child,
    );
  }

  Widget _buildSummaryRow(String title, String value,
      {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: color)),
        ],
      ),
    );
  }
}
