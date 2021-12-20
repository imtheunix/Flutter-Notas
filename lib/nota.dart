import 'dart:convert';

class Nota {
  int id;
  String nota;
  Nota({
    required this.id,
    required this.nota,
  });

  Nota copyWith({
    int? id,
    String? nota,
  }) {
    return Nota(
      id: id ?? this.id,
      nota: nota ?? this.nota,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': nota,
    };
  }

  factory Nota.fromMap(Map<String, dynamic> map) {
    return Nota(
      id: map['id'],
      nota: map['body'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Nota.fromJson(String source) => Nota.fromMap(json.decode(source));

  @override
  String toString() => 'Nota(id: $id, nota: $nota)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Nota && other.id == id && other.nota == nota;
  }

  @override
  int get hashCode => id.hashCode ^ nota.hashCode;
}
