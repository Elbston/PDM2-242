import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(this._nome);

  Map<String, dynamic> toJson() => {
        'nome': _nome,
      };
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(this._nome, this._dependentes);

  Map<String, dynamic> toJson() => {
        'nome': _nome,
        'dependentes': _dependentes.map((d) => d.toJson()).toList(),
      };
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(this._nomeProjeto, this._funcionarios);

  Map<String, dynamic> toJson() => {
        'nomeProjeto': _nomeProjeto,
        'funcionarios': _funcionarios.map((f) => f.toJson()).toList(),
      };
}

void main() {
  // Criando objetos Dependentes
  Dependente dependente1 = Dependente("Ana");
  Dependente dependente2 = Dependente("Carlos");
  Dependente dependente3 = Dependente("Maria");

  // Criando objetos Funcionarios com seus dependentes
  Funcionario funcionario1 = Funcionario("João", [dependente1, dependente2]);
  Funcionario funcionario2 = Funcionario("Pedro", [dependente3]);

  // Lista de Funcionarios
  List<Funcionario> funcionarios = [funcionario1, funcionario2];

  // Criando objeto EquipeProjeto
  EquipeProjeto equipeProjeto = EquipeProjeto("Projeto Alpha", funcionarios);

  // Convertendo EquipeProjeto para JSON com indentação
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String jsonEquipeProjeto = encoder.convert(equipeProjeto.toJson());
  print(jsonEquipeProjeto);
}
