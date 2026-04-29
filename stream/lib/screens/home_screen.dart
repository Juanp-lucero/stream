import 'package:flutter/material.dart';

import 'package:stream/models/crime_report.dart';
import 'package:stream/services/crime_stream_service.dart';
import 'package:stream/widgets/report_card.dart';
import 'package:stream/screens/add_report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CrimeStreamService service = CrimeStreamService();

  void _openAddReportScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReportScreen(
          onAdd: (report) {
            service.addReport(report);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🚨 Monitoreo de Delitos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddReportScreen,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<CrimeReport>>(
        stream: service.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No hay reportes aún"),
            );
          }

          final reports = snapshot.data!;

          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              return ReportCard(report: reports[index]);
            },
          );
        },
      ),
    );
  }
}