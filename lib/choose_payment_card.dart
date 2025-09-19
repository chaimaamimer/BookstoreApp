import 'package:flutter/material.dart';

class ChoosePaymentCard extends StatelessWidget {
  const ChoosePaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Payment"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(
                "assets/images/alg_poste logo.png", 
                width: 40,
                height: 40,
              ),
              title: const Text(
                "Carte Edahabia",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Algérie Poste"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pop(context, "Carte Edahabia");
              },
            ),
          ],
        ),
      ),
    );
  }
}
