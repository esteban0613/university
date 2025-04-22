import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/university_model.dart';

class UniversityDetailScreen extends StatefulWidget {
  final UniversityModel university;

  const UniversityDetailScreen({Key? key, required this.university}) : super(key: key);

  @override
  State<UniversityDetailScreen> createState() => _UniversityDetailScreenState();
}

class _UniversityDetailScreenState extends State<UniversityDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    if (widget.university.students != null) {
      _studentController.text = widget.university.students.toString();
    }
    _imageFile = widget.university.image;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveData() {
    if (_formKey.currentState!.validate()) {
      final students = int.tryParse(_studentController.text.trim());
      Navigator.pop(context, {
        'students': students,
        'image': _imageFile,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final u = widget.university;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.university.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Nombre: " + u.name,
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "País: " + u.country,
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Pagina web: " + u.webPages.first,
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Dominio: ${u.domains.length > 0 ? u.domains.first : 'No tiene dominio'}",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // Imagen
            _imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_imageFile!, height: 180, fit: BoxFit.cover),
                  )
                : Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.image, size: 60, color: Colors.grey[600]),
                  ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.photo),
                  label: Text("Galería"),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
                SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text("Cámara"),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
              ],
            ),
            SizedBox(height: 24),
            // Formulario
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _studentController,
                decoration: InputDecoration(
                  labelText: 'Número de estudiantes',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final intVal = int.tryParse(value ?? '');
                  if (value == null || value.isEmpty) return 'Este campo es obligatorio';
                  if (intVal == null || intVal < 0) return 'Debe ser un número válido';
                  return null;
                },
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Guardar'),
              onPressed: _saveData,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
