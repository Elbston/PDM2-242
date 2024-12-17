import 'package:flutter/material.dart';
import 'data/database_helper.dart';
import 'models/aluno.dart';

void main() {
  runApp(MaterialApp(
    home: AlunosApp(),
  ));
}

class AlunosApp extends StatefulWidget {
  @override
  _AlunosAppState createState() => _AlunosAppState();
}

class _AlunosAppState extends State<AlunosApp> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Aluno> _alunos = [];

  @override
  void initState() {
    super.initState();
    _fetchAlunos();
  }

  Future<void> _fetchAlunos() async {
    final alunos = await _dbHelper.getAlunos();
    setState(() {
      _alunos = alunos;
    });
  }

  Future<void> _addAluno(String nome, int idade) async {
    await _dbHelper.insertAluno(Aluno(nome: nome, idade: idade));
    _fetchAlunos();
  }

  Future<void> _updateAluno(Aluno aluno) async {
    aluno.nome = 'Nome Atualizado'; // Exemplo de alteração
    await _dbHelper.updateAluno(aluno);
    _fetchAlunos();
  }

  Future<void> _deleteAluno(int id) async {
    await _dbHelper.deleteAluno(id);
    _fetchAlunos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Alunos'),
      ),
      body: ListView.builder(
        itemCount: _alunos.length,
        itemBuilder: (context, index) {
          final aluno = _alunos[index];
          return ListTile(
            title: Text(aluno.nome),
            subtitle: Text('Idade: ${aluno.idade}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteAluno(aluno.id!),
            ),
            onTap: () => _updateAluno(aluno),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAluno('Novo Aluno', 20),
        child: Icon(Icons.add),
      ),
    );
  }
}
