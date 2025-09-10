import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/features/home/data/models/tram_grade_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/get_lesson_cubit/get_lesson_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/get_revisions_cubit/get_revisions_cubit.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/custom_lessons_list_view.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/custom_quiz_List_view.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/custom_reviews_list_view.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/custom_tap_item.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/tap_view_model.dart';

class CustomTapView extends StatefulWidget {
  const CustomTapView({super.key, required this.termModel});
  final TermModel termModel;

  @override
  State<CustomTapView> createState() => _CustomTapViewState();
}

class _CustomTapViewState extends State<CustomTapView>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    _tabController.animation?.addListener(() {
      final newIndex = _tabController.animation!.value.round();

      if (newIndex != selectedIndex) {
        setState(() {
          selectedIndex = newIndex;
        });
        if (newIndex == 0) {}
        if (newIndex == 1) {}
        if (newIndex == 2) {}

        if (newIndex == 3) {}
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TabBar(
          controller: _tabController,
          labelPadding: const EdgeInsets.all(0),
          dividerHeight: 0,
          indicatorColor: Colors.transparent,
          labelColor: AppColors.primary,
          tabs: tapViewModel.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == selectedIndex;
            final color = isSelected
                ? selectedTabColors[index]
                : Colors.grey.shade300;
            String? counter;
            if (index == 0) {}
            if (index == 1) {}
            if (index == 2) {}
            if (index == 3) {}
            return CustomTapItem(
              item: item,
              isSelected: isSelected,
              selectedColor: color,
              counter: counter ?? '0',
            );
          }).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BlocBuilder<GetLessonCubit, GetLessonState>(
                  builder: (context, state) {
                    if (state is GetLessonLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetLessonError) {
                      return Center(child: Text(state.errMessage));
                    } else if (state is GetLessonSuccess) {
                      final data = state.lessons;

                      if (state.lessons.isEmpty) {
                        return const CustomNoLesson();
                      }
                      return CustomLessonsListView(data: data);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BlocBuilder<GetRevisionsCubit, GetRevisionsState>(
                  builder: (context, state) {
                    if (state is GetRevisionsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetRevisionsError) {
                      return Center(child: Text(state.errMessage));
                    } else if (state is GetRevisionsSuccess) {
                      final data = state.lessons;

                      if (state.lessons.isEmpty) {
                        return const CustomNoLesson();
                      }
                      return CustomRevisionsListView(data: data);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomeValuationListView(),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomQuizListView(termModel: widget.termModel,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final List<Color> selectedTabColors = [
  AppColors.primary,
  AppColors.primary,
  AppColors.primary,
  AppColors.primary,
];



class CustomNoLesson extends StatelessWidget {
  const CustomNoLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            AppImage.noLesson,
            fit: BoxFit.cover,
            width: 300,
            height: 300,
          ),
        ),
      ],
    );
  }
}

class CustomeValuationListView extends StatelessWidget {
  const CustomeValuationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(AppImage.personIcon),
          ),
          title: Text('مستخدم $index'),
          subtitle: Text('هذا هو نص المراجعة للمستخدم $index.'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < 4 ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 16,
              );
            }),
          ),
        );
      },
    );
  }
}
