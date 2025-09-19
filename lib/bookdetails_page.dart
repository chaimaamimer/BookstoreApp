import 'package:bazar_app/cart_page.dart';
import 'package:bazar_app/home_page.dart';
import 'package:bazar_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'cart_class.dart';

class Book {
  final String title;
  final double price;
  final String image;
  int quantity;
  final double rating;
  final String vendorLogo;
  final String description;
  bool isLiked;

  Book({
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1,
    required this.rating,
    this.vendorLogo = 'assets/icons/vendor3.png',
    required this.description,
    this.isLiked = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      quantity: json['quantity'] ?? 1,
      rating: (json['rating'] as num).toDouble(),
      vendorLogo: json['vendorLogo'] ?? 'assets/icons/vendor3.png',
      description: json['description'] as String,
      isLiked: json['isLiked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'rating': rating,
      'vendorLogo': vendorLogo,
      'description': description,
      'isLiked': isLiked,
    };
  }
}

class BookDetailspage extends StatefulWidget {
  final Book book;

  const BookDetailspage({super.key, required this.book});

  @override
  State<BookDetailspage> createState() => _BookDetailspageState();
}

class _BookDetailspageState extends State<BookDetailspage> {
  late int selectedQuantity;

  @override
  void initState() {
    super.initState();
    selectedQuantity = widget.book.quantity; // garder la quantité du panier si déjà ajouté
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Book Details',
          style: TextStyle(
              color: AppColors.grey[900],
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Cover
              Center(
                child: Container(
                  width: 237,
                  height: 313,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(widget.book.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.book.title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        color: AppColors.grey[900]),
                  ),
                  // Favorite Icon
                  IconButton(
                    icon: Icon(
                      widget.book.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.book.isLiked
                          ? AppColors.primary[500]
                          : AppColors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        widget.book.isLiked = !widget.book.isLiked;
                      });
                      if (widget.book.isLiked) {
                        Cart.addBook(widget.book);
                      } else {
                        Cart.removeBook(widget.book);
                      }
                    },
                  ),
                ],
              ),
              //best vendor
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: AppColors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Image.asset(widget.book.vendorLogo)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              //about book
              Text(
                widget.book.description,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey[500],
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 16),
              //Rating
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Review",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey[900],
                      fontFamily: 'Roboto',
                    ),
                  ),
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < widget.book.rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 24,
                        );
                      }),
                      const SizedBox(width: 8),
                      Text(
                        widget.book.rating.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              //quantite
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (selectedQuantity > 1) {
                        setState(() {
                          selectedQuantity--;
                          widget.book.quantity = selectedQuantity;
                        });
                        Cart.updateQuantity(widget.book, selectedQuantity);
                      }
                    },
                    child: Image.asset("assets/icons/less.png"),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "$selectedQuantity",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedQuantity++;
                        widget.book.quantity = selectedQuantity;
                      });
                      Cart.updateQuantity(widget.book, selectedQuantity);
                    },
                    child: Image.asset("assets/icons/add.png"),
                  ),
                  const SizedBox(width: 12),
                  //Price (total)
                  Text(
                    "\$${(widget.book.price * selectedQuantity).toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary[500]),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //Add to Cart Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                      child: const Text(
                        "Continue shopping",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 115,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.grey[50],
                        foregroundColor: AppColors.primary[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(48),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()),
                        );
                      },
                      child: const Text(
                        "View cart",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
