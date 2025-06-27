import 'package:flutter/material.dart';

class PlanDeSalleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plan de Salle',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildToolbar(),
            const SizedBox(height: 16),
            Expanded(
              child: Stack(
                children: [
                  _buildFloorPlan(),
                  Positioned(right: 16, top: 16, child: _buildToolsPanel()),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Save layout
        },
        child: const Icon(Icons.save),
        tooltip: 'Enregistrer le plan',
      ),
    );
  }

  Widget _buildToolbar() {
    return Row(
      children: [
        Expanded(
          child: SegmentedButton<String>(
            segments: [
              const ButtonSegment(
                value: 'tables',
                icon: Icon(Icons.table_restaurant),
                label: Text('Tables'),
              ),
              const ButtonSegment(
                value: 'zones',
                icon: Icon(Icons.grid_view),
                label: Text('Zones'),
              ),
              ButtonSegment(
                value: 'murs',
                icon: const Icon(Icons.square_outlined),
                label: const Text('Murs'),
              ),
            ],
            selected: const {'tables'},
            onSelectionChanged: (Set<String> newSelection) {
              // Handle selection
            },
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.undo),
          onPressed: () {
            // Undo action
          },
          tooltip: 'Annuler',
        ),
        IconButton(
          icon: const Icon(Icons.redo),
          onPressed: () {
            // Redo action
          },
          tooltip: 'Rétablir',
        ),
      ],
    );
  }

  Widget _buildFloorPlan() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Stack(
        children: [
          // Example tables
          Positioned(left: 50, top: 50, child: _buildTable('T1', 4, true)),
          Positioned(left: 150, top: 50, child: _buildTable('T2', 2, false)),
          Positioned(left: 50, top: 150, child: _buildTable('T3', 6, false)),
          // Example zone
          Positioned(right: 100, top: 100, child: _buildZone('Terrasse')),
        ],
      ),
    );
  }

  Widget _buildTable(String id, int seats, bool isOccupied) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: isOccupied ? Colors.red[100] : Colors.green[100],
        border: Border.all(
          color: isOccupied ? Colors.red : Colors.green,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(id, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('$seats places'),
        ],
      ),
    );
  }

  Widget _buildZone(String name) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(
          color: Colors.blue,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildToolsPanel() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Add new element
              },
              tooltip: 'Ajouter',
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Delete selected element
              },
              tooltip: 'Supprimer',
            ),
            IconButton(
              icon: const Icon(Icons.rotate_right),
              onPressed: () {
                // Rotate selected element
              },
              tooltip: 'Rotation',
            ),
            IconButton(
              icon: const Icon(Icons.content_copy),
              onPressed: () {
                // Duplicate selected element
              },
              tooltip: 'Dupliquer',
            ),
          ],
        ),
      ),
    );
  }
}
