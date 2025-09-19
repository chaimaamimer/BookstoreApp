import 'package:bazar_app/notification_page.dart';
import 'package:bazar_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'bookdetails_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = loadBooks();
  }

  Future<List<Book>> loadBooks() async {
    final String response =
        await rootBundle.loadString('assets/data/books data.json');
    final List<dynamic> data = json.decode(response);
    return data.map((bookJson) => Book.fromJson(bookJson)).toList();
  }

  Widget _buildBookCard(Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookDetailspage(book: book),
          ),
        );
      },
      child: Container(
        width: 127,
        height: 150,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(book.image, height: 120, fit: BoxFit.cover)),
            const SizedBox(height: 6),
            Text(book.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey[900],
                    fontFamily: 'Roboto',
                    fontSize: 14)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  book.price.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary[500],
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(width: 2), 
                Text(
                  "\$",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary[500],
                    fontSize: 12, 
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget _buildVendorLogo(String image) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Image.asset(image)),
    );
  }

  Widget _buildAuthor(String name, String imageUrl, String grade) {
    return Column(
      children: [
        Container(
          width: 102,
          height: 102,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
              color: AppColors.grey[900]),
        ),
        const SizedBox(height: 4),
        Text(
          grade,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: AppColors.grey[500]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(
            color: AppColors.grey[900],
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.search, color: AppColors.grey[900]),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppColors.grey[900]),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Special Offer',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                              color: AppColors.grey[900],
                              letterSpacing: -3.0,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Discount 25%',
                            style: TextStyle(
                              color: AppColors.grey[900],
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 118,
                            height: 36,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary[500],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'Order Now',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 80,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/cardimage.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top of Week',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: AppColors.grey[900],
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: AppColors.primary[500],
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: FutureBuilder<List<Book>>(
                  future: futureBooks,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Erreur: ${snapshot.error}"));
                    }

                    final books = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return _buildBookCard(books[index]);
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Vendors',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                      color: AppColors.grey[900],
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: AppColors.primary[500],
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildVendorLogo("assets/icons/vendor1.png"),
                    _buildVendorLogo("assets/icons/vendor2.png"),
                    _buildVendorLogo("assets/icons/vendor3.png"),
                    _buildVendorLogo("assets/icons/vendor4.png"),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Authors
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Authors',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                      color: AppColors.grey[900],
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: AppColors.primary[500],
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildAuthor(
                      "John Freeman", "assets/images/author1.png", "Writer"),
                  _buildAuthor(
                      "Tess Gunty", "assets/images/author2.png", "Novelist"),
                  _buildAuthor(
                      "Richard Perry", "assets/images/author3.png", "Writer"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
