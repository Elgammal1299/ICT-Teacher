import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/features/accounts_students/data/model/accounts_model.dart';
import 'package:icd_teacher/features/accounts_students/ui/view_model/accounts_cubit/accounts_cubit.dart';

class AccountsStudentsPage extends StatelessWidget {
  const AccountsStudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Accounts")),
      body: BlocBuilder<AccountsCubit, AccountsState>(
        builder: (context, state) {
          if (state is AccountsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AccountsSuccess) {
            final accounts = state.data; // List<AccountsModel>
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final account = accounts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            StudentsPage(students: account.students),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        account.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "عدد الطلاب المسجلين: ${account.registeredStudents}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                );
              },
            );
          } else if (state is AccountsError) {
            return Center(child: Text("Error: ${state.errMessage}"));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class StudentsPage extends StatelessWidget {
  final List<StudentModel> students;

  const StudentsPage({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Students")),
      body: students.isEmpty
          ? const Center(child: Text("لا يوجد طلاب"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(student.fullName),
                    subtitle: Text(student.username),
                    trailing: Icon(
                      student.isActive ? Icons.check_circle : Icons.cancel,
                      color: student.isActive ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
