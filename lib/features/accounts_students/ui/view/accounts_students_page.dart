import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/error/error_state_widget.dart';
import 'package:icd_teacher/features/accounts_students/data/model/accounts_model.dart';
import 'package:icd_teacher/features/accounts_students/ui/view_model/accounts_cubit/accounts_cubit.dart';

class AccountsStudentsPage extends StatelessWidget {
  const AccountsStudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary, 
       foregroundColor: Colors.white,
        centerTitle: true,
        title:  Text("Accounts",style: TextStyle(fontFamily: 'Amiri')),),
     
      body: BlocBuilder<AccountsCubit, AccountsState>(
        builder: (context, state) {
          if (state is AccountsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AccountsSuccess) {
            final accounts = state.data; // List<AccountsModel>
            return ListView.builder(
              padding: EdgeInsets.all(12.w),
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
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.w),
                      title: Text(
                        account.name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "عدد الطلاب المسجلين: ${account.registeredStudents}",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                );
              },
            );
          } else if (state is AccountsError) {
            return ErrorStateWidget(
    message: state.errMessage,
  );
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
      appBar: AppBar(
        backgroundColor: AppColors.primary, 
       foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Students",style: TextStyle(fontFamily: 'Amiri'))),
      body: students.isEmpty
          ? Center(child: Text("لا يوجد طلاب"))
          : ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 6.h),
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
