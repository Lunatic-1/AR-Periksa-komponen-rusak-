import 'package:flutter/material.dart';
import '../models/component.dart';

class ComponentDetailScreen extends StatefulWidget {
  final Component component;

  const ComponentDetailScreen({super.key, required this.component});

  @override
  State<ComponentDetailScreen> createState() => _ComponentDetailScreenState();
}

class _ComponentDetailScreenState extends State<ComponentDetailScreen> {
  int _currentStep = 0;

  Color _statusColor(ComponentStatus status) {
    switch (status) {
      case ComponentStatus.normal:
        return Colors.green;
      case ComponentStatus.warning:
        return Colors.orange;
      case ComponentStatus.damaged:
        return Colors.redAccent;
    }
  }

  String _statusLabel(ComponentStatus status) {
    switch (status) {
      case ComponentStatus.normal:
        return 'Normal';
      case ComponentStatus.warning:
        return 'Perlu Perhatian';
      case ComponentStatus.damaged:
        return 'Rusak';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.component.name),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Header Status
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: _statusColor(widget.component.status).withOpacity(0.05),
              border: Border(
                bottom: BorderSide(
                  color: _statusColor(widget.component.status).withOpacity(0.2),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: _statusColor(widget.component.status),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Status: ${_statusLabel(widget.component.status)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _statusColor(widget.component.status),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.component.description,
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
              ],
            ),
          ),
          
          // Panduan Perbaikan dengan Stepper
          Expanded(
            child: widget.component.maintenanceSteps.isEmpty
                ? const Center(child: Text('Tidak ada tindakan yang diperlukan.'))
                : Stepper(
                    physics: const ClampingScrollPhysics(),
                    currentStep: _currentStep,
                    onStepContinue: () {
                      if (_currentStep < widget.component.maintenanceSteps.length - 1) {
                        setState(() {
                          _currentStep += 1;
                        });
                      }
                    },
                    onStepCancel: () {
                      if (_currentStep > 0) {
                        setState(() {
                          _currentStep -= 1;
                        });
                      }
                    },
                    onStepTapped: (step) {
                      setState(() {
                        _currentStep = step;
                      });
                    },
                    controlsBuilder: (BuildContext context, ControlsDetails details) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          children: [
                            if (_currentStep < widget.component.maintenanceSteps.length - 1)
                              ElevatedButton(
                                onPressed: details.onStepContinue,
                                child: const Text('Lanjut'),
                              ),
                            if (_currentStep == widget.component.maintenanceSteps.length - 1)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Maintenance Selesai!')),
                                  );
                                  Navigator.pop(context);
                                },
                                child: const Text('Selesai', style: TextStyle(color: Colors.white)),
                              ),
                            const SizedBox(width: 8),
                            if (_currentStep > 0)
                              TextButton(
                                onPressed: details.onStepCancel,
                                child: const Text('Kembali'),
                              ),
                          ],
                        ),
                      );
                    },
                    steps: widget.component.maintenanceSteps.asMap().entries.map((entry) {
                      final index = entry.key;
                      final step = entry.value;
                      return Step(
                        title: Text(
                          step.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            step.description,
                            style: const TextStyle(height: 1.5),
                          ),
                        ),
                        isActive: _currentStep >= index,
                        state: _currentStep > index ? StepState.complete : StepState.indexed,
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
