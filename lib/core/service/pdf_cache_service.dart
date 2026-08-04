import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdfCacheService {
  PdfCacheService(this._dio, this._sharedPreferences);

  final Dio _dio;
  final SharedPreferences _sharedPreferences;

  static const _pdfPathKeyPrefix = 'cached_pdf_path_';

  Future<String> getPdfPath(String pdfUrl) async {
    final cachedPath = _sharedPreferences.getString(_cacheKey(pdfUrl));
    if (cachedPath != null && cachedPath.isNotEmpty) {
      final cachedFile = File(cachedPath);
      if (await cachedFile.exists() && await cachedFile.length() > 0) {
        return cachedPath;
      }
    }

    final filePath = await _buildFilePath(pdfUrl);
    final file = File(filePath);
    await file.parent.create(recursive: true);

    await _dio.download(
      pdfUrl,
      filePath,
      options: Options(responseType: ResponseType.bytes),
    );

    await _sharedPreferences.setString(_cacheKey(pdfUrl), filePath);
    return filePath;
  }

  Future<String> _buildFilePath(String pdfUrl) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = _fileNameFromUrl(pdfUrl);
    return path.join(directory.path, 'pdf_cache', fileName);
  }

  String _fileNameFromUrl(String pdfUrl) {
    final uri = Uri.tryParse(pdfUrl);
    final extension = path.extension(uri?.path ?? '').isEmpty
        ? '.pdf'
        : path.extension(uri!.path);
    final hash = sha1.convert(utf8.encode(pdfUrl)).toString();
    return '$hash$extension';
  }

  String _cacheKey(String pdfUrl) {
    final hash = sha1.convert(utf8.encode(pdfUrl)).toString();
    return '$_pdfPathKeyPrefix$hash';
  }
}
