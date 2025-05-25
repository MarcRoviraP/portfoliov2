class Proyecto {
  final String imagen;
  final String titulo;
  final String descripcion;
  final String link;

  Proyecto({
    required this.imagen,
    required this.titulo,
    required this.descripcion,
    required this.link,
  });

  factory Proyecto.fromJson(Map<String, dynamic> json) {
    return Proyecto(
      imagen: json['imagen'] ?? '',
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      link: json['link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagen': imagen,
      'titulo': titulo,
      'descripcion': descripcion,
      'link': link,
    };
  }
}
