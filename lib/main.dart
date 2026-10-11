import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Nilai Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentGradeCalculator(),
    );
  }
}

class Student {
  final String name;
  final double tugas;
  final double uts;
  final double uas;
  final double finalScore;
  final String grade;
  final String status;

  Student({
    required this.name,
    required this.tugas,
    required this.uts,
    required this.uas,
    required this.finalScore,
    required this.grade,
    required this.status,
  });
}

class StudentGradeCalculator extends StatefulWidget {
  const StudentGradeCalculator({super.key});

  @override
  State<StudentGradeCalculator> createState() => _StudentGradeCalculatorState();
}

class _StudentGradeCalculatorState extends State<StudentGradeCalculator> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tugasController = TextEditingController();
  final TextEditingController _utsController = TextEditingController();
  final TextEditingController _uasController = TextEditingController();

  // Memuat 10 data sampel mahasiswa awal
  final List<Student> _studentList = [
    Student(name: "Ahmad Rizky", tugas: 85, uts: 80, uas: 90, finalScore: 85.5, grade: "A", status: "Lulus"),
    Student(name: "Budi Santoso", tugas: 70, uts: 75, uas: 80, finalScore: 75.5, grade: "B", status: "Lulus"),
    Student(name: "Citra Dewi", tugas: 60, uts: 65, uas: 70, finalScore: 65.5, grade: "C", status: "Lulus"),
    Student(name: "Dina Mariana", tugas: 50, uts: 55, uas: 50, finalScore: 51.5, grade: "D", status: "Tidak Lulus"),
    Student(name: "Eko Prasetyo", tugas: 40, uts: 45, uas: 30, finalScore: 37.5, grade: "E", status: "Tidak Lulus"),
    Student(name: "Fajar Nugraha", tugas: 90, uts: 85, uas: 95, finalScore: 90.5, grade: "A", status: "Lulus"),
    Student(name: "Gita Gutawa", tugas: 80, uts: 70, uas: 75, finalScore: 75.0, grade: "B", status: "Lulus"),
    Student(name: "Hadi Wijaya", tugas: 65, uts: 60, uas: 68, finalScore: 64.7, grade: "D", status: "Lulus"),
    Student(name: "Indah Permata", tugas: 95, uts: 90, uas: 92, finalScore: 92.3, grade: "A", status: "Lulus"),
    Student(name: "Joko Susilo", tugas: 55, uts: 50, uas: 45, finalScore: 49.5, grade: "E", status: "Tidak Lulus"),
  ];

  void _calculateAndAdd() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      double tugas = double.parse(_tugasController.text);
      double uts = double.parse(_utsController.text);
      double uas = double.parse(_uasController.text);

      double finalScore = (0.30 * tugas) + (0.30 * uts) + (0.40 * uas);

      String grade;
      if (finalScore >= 85) {
        grade = 'A';
      } else if (finalScore >= 75) {
        grade = 'B';
      } else if (finalScore >= 65) {
        grade = 'C';
      } else if (finalScore >= 50) {
        grade = 'D';
      } else {
        grade = 'E';
      }

      String status = finalScore >= 60 ? 'Lulus' : 'Tidak Lulus';

      setState(() {
        _studentList.insert(
          0,
          Student(
            name: name,
            tugas: tugas,
            uts: uts,
            uas: uas,
            finalScore: finalScore,
            grade: grade,
            status: status,
          ),
        );
      });

      _nameController.clear();
      _tugasController.clear();
      _utsController.clear();
      _uasController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data Mahasiswa Berhasil Ditambahkan!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Nilai Mahasiswa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nama Mahasiswa'),
                        validator: (value) => value!.isEmpty ? 'Nama harus diisi' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _tugasController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Nilai Tugas'),
                        validator: (value) => value!.isEmpty ? 'Nilai Tugas harus diisi' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _utsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Nilai UTS'),
                        validator: (value) => value!.isEmpty ? 'Nilai UTS harus diisi' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _uasController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Nilai UAS'),
                        validator: (value) => value!.isEmpty ? 'Nilai UAS harus diisi' : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _calculateAndAdd,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(45),
                        ),
                        child: const Text('Hitung & Simpan'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Daftar Mahasiswa (${_studentList.length} orang)',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(color: Colors.grey.shade300),
                columns: const [
                  DataColumn(label: Text('Nama', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Tugas', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('UTS', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('UAS', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Nilai Akhir', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Grade', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: _studentList.map((student) {
                  return DataRow(cells: [
                    DataCell(Text(student.name)),
                    DataCell(Text(student.tugas.toStringAsFixed(0))),
                    DataCell(Text(student.uts.toStringAsFixed(0))),
                    DataCell(Text(student.uas.toStringAsFixed(0))),
                    DataCell(Text(student.finalScore.toStringAsFixed(1))),
                    DataCell(Text(student.grade)),
                    DataCell(
                      Text(
                        student.status,
                        style: TextStyle(
                          color: student.status == 'Lulus' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}