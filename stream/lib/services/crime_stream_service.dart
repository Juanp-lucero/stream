import 'dart:async';
import 'package:stream/models/crime_report.dart';

class CrimeStreamService {
  // Lista privada de reportes
  final List<CrimeReport> _reports = [];

  // StreamController tipo broadcast
  final StreamController<List<CrimeReport>> _controller =
      StreamController<List<CrimeReport>>.broadcast();

  // Exponemos solo el stream (buena práctica)
  Stream<List<CrimeReport>> get stream => _controller.stream;

  // Método para agregar reportes
  void addReport(CrimeReport report) {
    _reports.add(report);

    // Emitimos una copia de la lista
    _controller.sink.add(List.from(_reports));
  }

  // Liberar recursos
  void dispose() {
    _controller.close();
  }
}