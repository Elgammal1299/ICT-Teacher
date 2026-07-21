import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_image.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;
  final Color color;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.color,
  });
}

final List<OnboardingModel> onboardingModelList = [
  OnboardingModel(
    title: 'مرحبًا بك في ICT Gate\nمرحبًا بك في مستقبل التعلم الرقمي',
    description:
        'مرحبًا بك في ICT Gate، المنصة التعليمية المتخصصة في تدريس البرمجة، والذكاء الاصطناعي ، الحاسب الآلي، تكنولوجيا المعلومات والاتصالات.\nصُممت المنصة لتقديم تجربة تعليمية حديثة تجمع بين الشرح المبسط، والتطبيق العملي، والاختبارات التفاعلية، لمساعدة الطلاب على تحقيق التفوق الدراسي وبناء مهارات المستقبل.',
    imagePath: AppImage.logo,
    color: const Color(0xFF4CAF50),
  ),
  OnboardingModel(
    title: 'منصة واحدة... لجميع المراحل الدراسية',
    description:
        'تقدم ICT Gate محتوى تعليميًا متكاملًا لطلاب:\nالمرحلة الابتدائية (تكنولوجيا المعلومات والاتصالات)\nالمرحلة الإعدادية (الحاسب الآلي وتكنولوجيا المعلومات والاتصالات)\nالمرحلة الثانوية (البرمجة والذكاء الاصطناعي)\nويتم إعداد المحتوى ومراجعته بمشاركة اثنين من المعلمين المتخصصين، يجمعان بين الخبرة التربوية والأساليب التعليمية الحديثة، لضمان تقديم محتوى دقيق، مبسط، ومتوافق مع المناهج الدراسية.',
    imagePath: AppImage.ahmedSaif,
    color: const Color(0xFF2196F3),
  ),
  OnboardingModel(
    title: 'الأستاذ سيف سالم، موجه الحاسب الآلي وتكنولوجيا المعلومات والاتصالات بمحافظة المنوفية، ولدي أكثر من **30 عامًا* من الخبرة في تدريس المادة والإشراف عليها.',
    description:
        'شاركت في إعداد المحتوى العلمي لمنصة *ICT Gate* ليكون متوافقًا مع المنهج الدراسي، واضحًا، ودقيقًا، ويساعد كل طالب على الفهم الحقيقي وليس مجرد حفظ المعلومات.\nيساهم في إعداد ومراجعة المحتوى العلمي داخل ICT Gate لضمان تقديم مادة تعليمية دقيقة، واضحة، ومتوافقة مع المناهج الدراسية، بما يساعد الطلاب على تحقيق أفضل النتائج.\nهدفي أن تجد داخل هذه المنصة محتوى تعليميًا موثوقًا يدعمك خطوة بخطوة حتى تحقق التميز الدراسي وتكتسب المهارات التي يحتاجها المستقبل.',
    imagePath: AppImage.saif,
    color: const Color(0xFFFF9800),
  ),
  OnboardingModel(
    title: 'الأستاذ أحمد سيف*، معلم تكنولوجيا المعلومات والاتصالات، وخريج قسم الحاسب الآلي وتكنولوجيا المعلومات والاتصالات',
    description:
        "أنشأت منصة *ICT Gate* لأنني أؤمن أن التكنولوجيا لا ينبغي أن تكون مادة للحفظ، بل مهارة تُفهم وتُمارس. لذلك ستجد هنا شرحًا مبسطًا، وتدريبات عملية، واختبارات تفاعلية تساعدك على إتقان المنهج وبناء مهارات حقيقية في التكنولوجيا والبرمجة والذكاء الاصطناعي\nأؤمن بأن التعلم الحقيقي يبدأ بالفهم والتطبيق، لذلك أعمل على تقديم محتوى تعليمي يجعل التكنولوجيا والبرمجة والذكاء الاصطناعي سهلة، ممتعة، وقريبة من جميع الطلاب\nأتمنى أن تكون هذه المنصة بداية رحلتك نحو التعلم والإبداع، وأن تحقق من خلالها أفضل النتائج بإذن الله.",
    imagePath: AppImage.ahmed,
    color: const Color(0xFF9C27B0),
  ),
  // OnboardingModel(
  //   title: 'Get Started',
  //   description:
  //       'Join thousands of educators who are transforming their classrooms with Teacher ICT.',
  //   imagePath: AppImage.logo2,
  //   color: const Color(0xFFE91E63),
  // ),
];
