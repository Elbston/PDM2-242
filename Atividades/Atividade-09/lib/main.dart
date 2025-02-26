    import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(GoogleBooksApp());
}

class GoogleBooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pesquise no Google Livros',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BookSearchScreen(),
    );
  }
}

class BookSearchScreen extends StatefulWidget {
  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List books = [];

  Future<void> fetchBooks(String query) async {
    final url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        books = data['items'] ?? [];
      });
    } else {
      throw Exception('Erro ao carregar os livros');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Livros')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Buscar livro',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => fetchBooks(_controller.text),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index]['volumeInfo'];
                  return ListTile(
                    title: Text(book['title'] ?? 'Sem título'),
                    subtitle: Text(book['authors']?.join(', ') ?? 'Autor desconhecido'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
