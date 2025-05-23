class Experiencia {
  final String funcion;
  final String lugar;
  final String fecha;
  final String descripcion;

  Experiencia({
    required this.funcion,
    required this.lugar,
    required this.fecha,
    required this.descripcion,
  });

  factory Experiencia.fromJson(Map<String, dynamic> json) {
    return Experiencia(
      funcion: json['funcion'],
      lugar: json['lugar'],
      fecha: json['fecha'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'funcion': funcion,
      'lugar': lugar,
      'fecha': fecha,
      'descripcion': descripcion,
    };
  }
}
