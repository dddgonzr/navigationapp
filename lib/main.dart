import 'package:flutter/material.dart';

void main() {
  runApp(MyLibraryApp());
}

class MyLibraryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca Virtual',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Book> favoriteBooks = [];

  static List<Book> books = [
    Book(title: "El Señor de los Anillos", author: "J.R.R. Tolkien", description: "Una aventura épica en la Tierra Media."),
    Book(title: "Cien Años de Soledad", author: "Gabriel García Márquez", description: "La historia de la familia Buendía."),
    Book(title: "1984", author: "George Orwell", description: "Una distopía sobre un futuro totalitario."),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void addFavorite(Book book) {
    setState(() {
      favoriteBooks.add(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biblioteca Virtual'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menú'),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
            ),
            ListTile(
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0
          ? BooksListScreen(books: books, addFavorite: addFavorite)
          : FavoriteBooksScreen(favoriteBooks: favoriteBooks),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Libros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}


class BooksListScreen extends StatelessWidget {
  final List<Book> books;
  final Function(Book) addFavorite;

  BooksListScreen({required this.books, required this.addFavorite});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(books[index].title),
          subtitle: Text(books[index].author),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailScreen(
                  book: books[index],
                  addFavorite: addFavorite,
                ),
              ),
            );
          },
        );
      },
    );
  }
}


class BookDetailScreen extends StatelessWidget {
  final Book book;
  final Function(Book) addFavorite;

  BookDetailScreen({required this.book, required this.addFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              book.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Autor: ${book.author}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              book.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                addFavorite(book);
                Navigator.pop(context);
              },
              child: Text('Añadir a Favoritos'),
            ),
          ],
        ),
      ),
    );
  }
}


class FavoriteBooksScreen extends StatelessWidget {
  final List<Book> favoriteBooks;

  FavoriteBooksScreen({required this.favoriteBooks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteBooks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(favoriteBooks[index].title),
          subtitle: Text(favoriteBooks[index].author),
        );
      },
    );
  }
}


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: Center(
        child: Text('Pantalla de Configuración'),
      ),
    );
  }
}


class Book {
  final String title;
  final String author;
  final String description;

  Book({required this.title, required this.author, required this.description});
}