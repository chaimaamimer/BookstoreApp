import 'package:bazar_app/bookdetails_page.dart';

class Cart {
  static final List<Book> items = [];

  static void addBook(Book book) {
    final existingIndex = items.indexWhere((b) => b.title == book.title);

    if (existingIndex != -1) {

      items[existingIndex].quantity += book.quantity;
    } else {

      items.add(Book(
        title: book.title,
        price: book.price,
        image: book.image,
        quantity: book.quantity,
        rating: book.rating,
        vendorLogo: book.vendorLogo,
        description: book.description,
        isLiked: true,
      ));
    }
  }

  static void removeBook(Book book) {
    items.removeWhere((b) => b.title == book.title);
  }

  static void updateQuantity(Book book, int newQuantity) {
    final existingIndex = items.indexWhere((b) => b.title == book.title);
    if (existingIndex != -1) {
      items[existingIndex].quantity = newQuantity;
    }
  }

  static double getTotalPrice() {
    return items.fold(
      0,
      (total, book) => total + (book.price * book.quantity),
    );
  }

  static int getTotalItems() {
    return items.fold(0, (total, book) => total + book.quantity);
  }
}
