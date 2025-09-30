// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:icd_teacher/features/accounts_students/ui/view_model/accounts_cubit/accounts_cubit.dart';

// class AccountsStudentsPage extends StatelessWidget {
//   const AccountsStudentsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('سجل الطلاب')),
//       body: BlocBuilder<AccountsCubit, AccountsState>(
//         builder: (context, state) {
//           if (state is AccountsLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is AccountsSuccess) {
//             final accounts = state.data; // List<AccountsModel>
//             if (accounts.isEmpty) {
//               return const Center(child: Text('لا يوجد صفوف'));
//             }
//             return ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: accounts.length,
//               itemBuilder: (context, index) {
//                 final account = accounts[index];
//                 return GestureDetector(
//                   onTap: () {
//                     // Navigator.of(context).push(
//                     //   MaterialPageRoute(
//                     //     builder: (_) => StudentsPage(
//                     //       gradeName: account.name,
//                     //       students: account.students,
//                     //     ),
//                     //   ),
//                     // );
//                   },
//                   child: Card(
//                     elevation: 4,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 28,
//                             backgroundColor: Colors.blue.shade100,
//                             child: Text(
//                               account.name.substring(0, 2),
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 20),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   account.name,
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.people, size: 18, color: Colors.grey),
//                                     const SizedBox(width: 4),
//                                     Text(
//                                       '${account.registeredStudents} طالب',
//                                       style: const TextStyle(
//                                         fontSize: 15,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 if (account.students.isNotEmpty) ...[
//                                   const SizedBox(height: 8),
//                                   SizedBox(
//                                     height: 28,
//                                     child: ListView.separated(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: account.students.length > 3 ? 3 : account.students.length,
//                                       separatorBuilder: (_, __) => const SizedBox(width: 6),
//                                       itemBuilder: (context, idx) {
//                                         final student = account.students[idx];
//                                         return Chip(
//                                           label: Text(
//                                             student.fullName,
//                                             style: const TextStyle(fontSize: 12),
//                                           ),
//                                           backgroundColor: student.isActive
//                                               ? Colors.green.shade100
//                                               : Colors.grey.shade200,
//                                           avatar: Icon(
//                                             student.isActive ? Icons.check_circle : Icons.cancel,
//                                             color: student.isActive ? Colors.green : Colors.grey,
//                                             size: 16,
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   if (account.students.length > 3)
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 4),
//                                       child: Text(
//                                         '+${account.students.length - 3} آخرين',
//                                         style: const TextStyle(fontSize: 12, color: Colors.grey),
//                                       ),
//                                     ),
//                                 ],
//                               ],
//                             ),
//                           ),
//                           const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (state is AccountsError) {
//             return Center(child: Text('حدث خطأ: ${state.errMessage}'));
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
//   }

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
