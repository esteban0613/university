import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/models/university_model.dart';
import '../screens/university_detail_screen.dart';

class UniversityCard extends StatelessWidget {
  final UniversityModel university;

  const UniversityCard({Key? key, required this.university}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(
              builder: (_) => UniversityDetailScreen(university: university),
            ),
          );

          if (result != null) {
            university.students = result['students'];
            university.image = result['image'];
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    university.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6),
                  Text(
                    university.country,
                    style: TextStyle(color: Colors.grey[700]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
