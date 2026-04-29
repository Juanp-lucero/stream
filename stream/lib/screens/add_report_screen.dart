import 'package:flutter/material.dart';
import 'package:stream/models/crime_report.dart';

class AddReportScreen extends StatefulWidget {
  final Function(CrimeReport) onAdd;

  const AddReportScreen({super.key, required this.onAdd});

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedType;
  String location = '';

  final List<String> types = ["Robo", "Accidente", "Vandalismo"];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final report = CrimeReport(
        id: DateTime.now().toString(),
        type: selectedType!,
        location: location,
        timestamp: DateTime.now(),
      );

      widget.onAdd(report);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Reporte"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //  DROPDOWN
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Tipo de delito",
                ),
                items: types.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedType = value;
                },
                validator: (value) =>
                    value == null ? "Selecciona un tipo" : null,
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: "Ubicación"),
                validator: (value) =>
                    value!.isEmpty ? "Campo requerido" : null,
                onSaved: (value) => location = value!,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submit,
                child: const Text("Guardar Reporte"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}