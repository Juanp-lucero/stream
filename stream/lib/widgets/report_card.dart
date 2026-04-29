import 'package:flutter/material.dart';
import 'package:stream/models/crime_report.dart';

class ReportCard extends StatelessWidget {
  final CrimeReport report;

  const ReportCard({super.key, required this.report});

  IconData _getIcon(String type) {
    switch (type) {
      case "Robo":
        return Icons.security;
      case "Accidente":
        return Icons.car_crash;
      case "Vandalismo":
        return Icons.warning;
      default:
        return Icons.report;
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case "Robo":
        return Colors.redAccent;
      case "Accidente":
        return Colors.orangeAccent;
      case "Vandalismo":
        return Colors.purpleAccent;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(report.type);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A1A2E),
            const Color(0xFF16213E),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(_getIcon(report.type), color: color, size: 30),
        title: Text(
          report.type,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          "${report.location} • ${_formatDate(report.timestamp)}",
        ),
      ),
    );
  }
}