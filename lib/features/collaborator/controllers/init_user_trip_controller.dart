import 'package:bag_finder/core/entity/tag_entity.dart';
import '../../../core/entity/traveler_entity.dart';

class InitUserTripController {
  // --- CAMPOS PRIVADOS ---
  String _destination = '';
  String _airportOrigin = '';
  String _airportDestination = '';
  String? _connection = null;
  String _cpf = '';
  String? _description = '';
  int? _bagageQuantity = 0;
  TravelerEntity _travelerEntity = TravelerEntity.empty();

  // --- LISTAS DE TAGS ---
  // Lista para armazenar o EPC lido (TAG-RFID)
  List<String> codeTags = [];
  // 💡 NOVO CAMPO: Lista para armazenar o Código Impresso (preenchimento manual)
  List<String> printedCodes = [];

  // --- GETTERS ---
  int get bagageQuantity => _bagageQuantity ?? 0;
  String get destination => _destination;
  String get airportOrigin => _airportOrigin;
  String get airportDestination => _airportDestination;
  String? get connection => _connection;
  String get cpf => _cpf;
  String? get description => _description;
  TravelerEntity get user => _travelerEntity;

  // --- SETTERS E MÉTODOS ---

  void setUser({
    required TravelerEntity? user,
  }) {
    _travelerEntity = user ?? TravelerEntity.empty();
  }

  void setCpf({required String? cpf}) {
    if (cpf == null) return;
    final cleanedCpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    _cpf = cleanedCpf;
  }

  void setDescription({
    required String? description,
  }) {
    _description = description;
  }

  void setDestination({
    required String destination,
  }) {
    _destination = destination;
  }

  void setAirportOrigin({
    required String airportOrigin,
  }) {
    _airportOrigin = airportOrigin;
  }

  void setConnection({
    required String? connection,
  }) {
    // Se a string for vazia, definimos como null para o backend entender que é opcional
    _connection =
        (connection != null && connection.isEmpty) ? null : connection;
  }

  void setAirportDestination({
    required String airportDestination,
  }) {
    _airportDestination = airportDestination;
  }

  void setBagageQuantity({
    required int? bagageQuantity,
  }) {
    _bagageQuantity = bagageQuantity;
    // Redimensiona a lista de tags (como a quantidade é ditada pela leitura agora,
    // este método pode ser opcional ou deve ser chamado com newSize = 0)
    final newSize = bagageQuantity ?? 0;
    codeTags = List.filled(newSize, '', growable: true);
    // 💡 Redimensiona a lista de printed codes para manter o alinhamento
    printedCodes = List.filled(newSize, '', growable: true);
  }

  void clearFields() {
    _destination = '';
    _airportOrigin = '';
    _airportDestination = '';
    _description = '';
    _bagageQuantity = 0;
    codeTags = [];
    printedCodes = []; // Limpa a nova lista também
  }

  // 📌 Método para adicionar ou atualizar o Código da TAG (EPC)
  void addTagCodeAtIndex(int index, String code) {
    if (code.isEmpty) return;

    if (codeTags.length > index) {
      codeTags[index] = code;
    } else {
      while (codeTags.length <= index) {
        codeTags.add('');
      }
      codeTags[index] = code;
    }
  }

  // 📌 NOVO MÉTODO: Adiciona ou atualiza o Código Impresso (Printed Code)
  void addPrintedCodeAtIndex(int index, String code) {
    // Note: Não precisamos checar code.isEmpty aqui, pois o campo pode ficar vazio.

    if (printedCodes.length > index) {
      printedCodes[index] = code;
    } else {
      // Garante que a lista printedCodes cresça se a lista codeTags crescer
      while (printedCodes.length <= index) {
        printedCodes.add('');
      }
      printedCodes[index] = code;
    }
  }
}
