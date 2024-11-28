class Aluno {
  int id;
  String nome;
  String dataNascimento;

  // Usando 'required' para garantir que esses parâmetros não sejam nulos
  Aluno({required this.id, required this.nome, required this.dataNascimento});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data_nascimento': dataNascimento,
    };
  }

  @override
  String toString() {
    return 'Aluno{id: $id, nome: $nome, data_nascimento: $dataNascimento}';
  }
}

class AlunoDatabase {
  static final AlunoDatabase instance = AlunoDatabase._init();
  final List<Aluno> _alunos = [];  // Lista para armazenar alunos em memória

  AlunoDatabase._init();

  // Simula a inserção de um aluno
  Future<int> insertAluno(Aluno aluno) async {
    aluno.id = _alunos.length + 1;  // Gera um ID simples para o aluno
    _alunos.add(aluno);
    return aluno.id;
  }

  // Simula a recuperação de um aluno pelo ID
  Future<Aluno?> getAluno(int id) async {
    // Agora, retornamos 'null' explicitamente, já que a função pode retornar nulo
    return _alunos.firstWhere((aluno) => aluno.id == id);
  }

  // Simula a recuperação de todos os alunos
  Future<List<Aluno>> getAllAlunos() async {
    return _alunos;
  }

  // Simula a atualização de um aluno
  Future<int> updateAluno(Aluno aluno) async {
    final index = _alunos.indexWhere((a) => a.id == aluno.id);
    if (index != -1) {
      _alunos[index] = aluno;
      return 1;
    }
    return 0;
  }

  // Simula a exclusão de um aluno
  Future<int> deleteAluno(int id) async {
    final index = _alunos.indexWhere((aluno) => aluno.id == id);
    if (index != -1) {
      _alunos.removeAt(index);
      return 1;
    }
    return 0;
  }
}

void main() async {
  // Inicializar o banco de dados (em memória)
  final db = AlunoDatabase.instance;

  // Inserir dois alunos
  final aluno1 = Aluno(id: 0, nome: 'Elbston', dataNascimento: '2006-27-04');
  final aluno2 = Aluno(id: 0, nome: 'Enzo', dataNascimento: '2007-31-01');
  final aluno3 = Aluno(id: 0, nome: 'Lucas', dataNascimento: '2007-05-03');
  await db.insertAluno(aluno1);
  await db.insertAluno(aluno2);
  await db.insertAluno(aluno3);

  // Buscar todos os alunos
  List<Aluno> alunos = await db.getAllAlunos();

  // Imprimir os nomes dos alunos
  print('Nomes dos alunos:');
  for (var aluno in alunos) {
    print(aluno.nome);
  }

  // Atualizar o nome de um aluno
  aluno1.nome = 'Elbston Souza Lima Filho';
  await db.updateAluno(aluno1);
  aluno3.nome = 'Lucas Gonzaga de Andrade';
  await db.updateAluno(aluno3);

  // Deletar o aluno2
  await db.deleteAluno(aluno2.id);

  // Verificar os alunos restantes
  List<Aluno> alunosRestantes = await db.getAllAlunos();
  print('Alunos restantes após a exclusão:');
  for (var aluno in alunosRestantes) {
    print(aluno.nome);
  }
}
