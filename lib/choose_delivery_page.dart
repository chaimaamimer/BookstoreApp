import 'package:flutter/material.dart';

class ChooseDeliveryPage extends StatefulWidget {
  const ChooseDeliveryPage({super.key});

  @override
  State<ChooseDeliveryPage> createState() => _ChooseDeliveryPageState();
}

class _ChooseDeliveryPageState extends State<ChooseDeliveryPage> {
  String? selectedDate;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Choose Delivery",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontFamily: 'Roboto'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Delivery date
            const Text("Delivery date",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Roboto')),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildChoiceChip("Today 12 Jan"),
                const SizedBox(width: 8),
                _buildChoiceChip("Tomorrow 13 Jan"),
                const SizedBox(width: 8),
                _buildChoiceChip("Pick a date", isDatePicker: true),
              ],
            ),
            const SizedBox(height: 20),

            // Delivery time
            const Text("Delivery time",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Roboto')),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildTimeChip("10PM - 11PM"),
                _buildTimeChip("11PM - 12PM"),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate != null && selectedTime != null) {
                    Navigator.pop(context, {
                      "date": selectedDate,
                      "time": selectedTime,
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select date & time",style:TextStyle( fontFamily: 'Roboto'),
                      ),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label, {bool isDatePicker = false}) {
    final bool isSelected = selectedDate == label;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) async {
        if (isDatePicker) {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2030),
          );
          if (picked != null) {
            setState(() {
              selectedDate =
                  "${picked.day}/${picked.month}/${picked.year}";
            });
          }
        } else {
          setState(() {
            selectedDate = label;
          });
        }
      },
      selectedColor: Colors.deepPurple.withOpacity(0.2),
      labelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? Colors.deepPurple : Colors.black,
      ),
    );
  }

  Widget _buildTimeChip(String label) {
    final bool isSelected = selectedTime == label;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        setState(() {
          selectedTime = label;
        });
      },
      selectedColor: Colors.deepPurple.withOpacity(0.2),
      labelStyle: TextStyle(
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? Colors.deepPurple : Colors.black,
      ),
    );
  }
}
