// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:icd_teacher/core/DI/setup_get_it.dart';
// import 'package:icd_teacher/core/constant/app_color.dart';
// import 'package:icd_teacher/core/service/pdf_cache_service.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class PdfViewerPage extends StatefulWidget {
//   final String pdfUrl;

//   const PdfViewerPage({super.key, required this.pdfUrl});

//   @override
//   State<PdfViewerPage> createState() => _PdfViewerPageState();
// }

// class _PdfViewerPageState extends State<PdfViewerPage> {
//   late final Future<String> _pdfPathFuture;

//   @override
//   void initState() {
//     super.initState();
//     _pdfPathFuture = getIt<PdfCacheService>().getPdfPath(widget.pdfUrl);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primary, 
//        foregroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text('عرض الملف' ,style: TextStyle(fontFamily: 'IBMPlexSansArabic')),
       
//       ),
//       body: FutureBuilder<String>(
//         future: _pdfPathFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError || !snapshot.hasData) {
//             return const Center(child: Text('تعذر فتح ملف PDF'));
//           }

//           return SfPdfViewer.file(File(snapshot.data!));
//         },
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:icd_teacher/core/DI/setup_get_it.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/service/pdf_cache_service.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:no_screenshot/no_screenshot.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfUrl;

  const PdfViewerPage({
    super.key,
    required this.pdfUrl,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late final Future<String> _pdfPathFuture;

  final NoScreenshot _noScreenshot = NoScreenshot.instance;

  @override
  void initState() {
    super.initState();

    // منع Screenshot و Screen Recording
    _disableScreenshot();

    // تحميل ملف PDF
    _pdfPathFuture = getIt<PdfCacheService>().getPdfPath(widget.pdfUrl);
  }

  Future<void> _disableScreenshot() async {
    await _noScreenshot.screenshotOff();
  }

  Future<void> _enableScreenshot() async {
    await _noScreenshot.screenshotOn();
  }

  @override
  void dispose() {
    // السماح بالـ Screenshot مرة أخرى
    _enableScreenshot();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'عرض الملف',
          style: TextStyle(
            fontFamily: 'IBMPlexSansArabic',
          ),
        ),
      ),
      body: FutureBuilder<String>(
        future: _pdfPathFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text('تعذر فتح ملف PDF'),
            );
          }

          return SfPdfViewer.file(
            File(snapshot.data!),
          );
        },
      ),
    );
  }
}