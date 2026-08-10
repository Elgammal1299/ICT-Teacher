import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:highlight/languages/javascript.dart';

class CodeExercise {
  const CodeExercise({
    this.title = 'محرر JavaScript',
    this.instructions = '',
    this.initialCode = '',
  });

  final String title;
  final String instructions;
  final String initialCode;
}

class NativeCodePlaygroundScreen extends StatefulWidget {
  const NativeCodePlaygroundScreen({
    super.key,
    this.exercise = const CodeExercise(),
  });

  final CodeExercise exercise;

  @override
  State<NativeCodePlaygroundScreen> createState() =>
      _NativeCodePlaygroundScreenState();
}

class _NativeCodePlaygroundScreenState
    extends State<NativeCodePlaygroundScreen> {
  late final CodeController _codeController;
  late final JavascriptRuntime _javascriptRuntime;

  final List<ConsoleEntry> _consoleEntries = [];

  bool _isRunning = false;
  bool _hasExecutionError = false;
  String? _feedback;
  int? _executionTime;

  @override
  void initState() {
    super.initState();

    _codeController = CodeController(
      text: widget.exercise.initialCode,
      language: javascript,
    );

    _javascriptRuntime = getJavascriptRuntime(
      forceJavascriptCoreOnAndroid: true,
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _javascriptRuntime.dispose();
    super.dispose();
  }

  String _createExecutableScript(String studentCode) {
    final encodedCode = jsonEncode(studentCode);

    return '''
(function () {
  const __outputs = [];

  function __serialize(value) {
    if (typeof value === "string") return value;
    if (typeof value === "undefined") return "undefined";
    if (value === null) return "null";

    try {
      return JSON.stringify(value);
    } catch (_) {
      return String(value);
    }
  }

  const console = {
    log: function (...values) {
      __outputs.push({
        type: "output",
        text: values.map(__serialize).join(" ")
      });
    },

    info: function (...values) {
      __outputs.push({
        type: "info",
        text: values.map(__serialize).join(" ")
      });
    },

    warn: function (...values) {
      __outputs.push({
        type: "warning",
        text: values.map(__serialize).join(" ")
      });
    },

    error: function (...values) {
      __outputs.push({
        type: "error",
        text: values.map(__serialize).join(" ")
      });
    }
  };

  try {
    const __studentCode = $encodedCode;
    const __runner = new Function("console", __studentCode);

    __runner(console);

    return JSON.stringify({
      success: true,
      outputs: __outputs
    });
  } catch (error) {
    return JSON.stringify({
      success: false,
      outputs: __outputs,
      errorName: error.name || "Error",
      errorMessage: error.message || String(error),
      errorStack: error.stack || ""
    });
  }
})()
''';
  }

  Future<void> _runCode() async {
    if (_isRunning) return;

    FocusScope.of(context).unfocus();
    final studentCode = _codeController.fullText;

    setState(() {
      _isRunning = true;
      _hasExecutionError = false;
      _feedback = null;
      _executionTime = null;
      _consoleEntries.clear();
    });

    if (studentCode.trim().isEmpty) {
      setState(() {
        _isRunning = false;
        _hasExecutionError = true;
        _feedback = 'اكتب كود JavaScript أولًا ثم اضغط تشغيل.';
        _consoleEntries.add(
          const ConsoleEntry(
            text: 'لا يوجد كود للتنفيذ.',
            type: ConsoleEntryType.error,
          ),
        );
      });
      return;
    }

    final stopwatch = Stopwatch()..start();

    try {
      final script = _createExecutableScript(studentCode);

      final result = await Future<JsEvalResult>(() {
        return _javascriptRuntime.evaluate(script);
      }).timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          throw TimeoutException(
            'استغرق الكود وقتًا أطول من المسموح.',
          );
        },
      );

      stopwatch.stop();

      if (result.isError) {
        _showExecutionError(
          result.stringResult,
          executionTime: stopwatch.elapsedMilliseconds,
        );
        return;
      }

      final dynamic rawDecoded = jsonDecode(result.stringResult);

      if (rawDecoded is! Map) {
        throw const FormatException('نتيجة التنفيذ غير صالحة.');
      }

      final decoded = Map<String, dynamic>.from(rawDecoded);
      final success = decoded['success'] == true;

      final rawOutputs = decoded['outputs'];

      if (rawOutputs is List) {
        for (final item in rawOutputs) {
          if (item is Map) {
            final output = Map<String, dynamic>.from(item);
            final text = output['text']?.toString() ?? '';
            final type = output['type']?.toString() ?? 'output';

            _consoleEntries.add(
              ConsoleEntry(
                text: text,
                type: _consoleTypeFromJs(type),
              ),
            );
          } else {
            _consoleEntries.add(
              ConsoleEntry(
                text: item.toString(),
                type: ConsoleEntryType.output,
              ),
            );
          }
        }
      }

      if (!success) {
        final errorName =
            decoded['errorName']?.toString() ?? 'Error';

        final errorMessage =
            decoded['errorMessage']?.toString() ??
            'حدث خطأ أثناء التنفيذ.';

        _consoleEntries.add(
          ConsoleEntry(
            text: '$errorName: $errorMessage',
            type: ConsoleEntryType.error,
          ),
        );

        if (!mounted) return;

        setState(() {
          _isRunning = false;
          _hasExecutionError = true;
          _feedback = _translateCommonError(errorMessage);
          _executionTime = stopwatch.elapsedMilliseconds;
        });

        return;
      }

      if (_consoleEntries.isEmpty) {
        _consoleEntries.add(
          const ConsoleEntry(
            text: 'تم تنفيذ الكود بنجاح، ولا توجد مخرجات في Console.',
            type: ConsoleEntryType.success,
          ),
        );
      } else {
        _consoleEntries.add(
          const ConsoleEntry(
            text: 'تم تنفيذ الكود بنجاح.',
            type: ConsoleEntryType.success,
          ),
        );
      }

      if (!mounted) return;

      setState(() {
        _isRunning = false;
        _hasExecutionError = false;
        _executionTime = stopwatch.elapsedMilliseconds;
        _feedback = null;
      });
    } on TimeoutException {
      stopwatch.stop();

      if (!mounted) return;

      setState(() {
        _isRunning = false;
        _hasExecutionError = true;
        _executionTime = stopwatch.elapsedMilliseconds;
        _feedback =
            'استغرق الكود وقتًا طويلًا. راجع الحلقات التكرارية في الكود.';

        _consoleEntries.add(
          const ConsoleEntry(
            text: 'انتهت مهلة التنفيذ. راجع شرط الحلقة التكرارية.',
            type: ConsoleEntryType.error,
          ),
        );
      });
    } catch (error) {
      stopwatch.stop();

      _showExecutionError(
        error.toString(),
        executionTime: stopwatch.elapsedMilliseconds,
      );
    }
  }

  ConsoleEntryType _consoleTypeFromJs(String type) {
    return switch (type) {
      'info' => ConsoleEntryType.info,
      'warning' => ConsoleEntryType.warning,
      'error' => ConsoleEntryType.error,
      _ => ConsoleEntryType.output,
    };
  }

  void _showExecutionError(
    String error, {
    int? executionTime,
  }) {
    if (!mounted) return;

    setState(() {
      _isRunning = false;
      _hasExecutionError = true;
      _feedback = 'تعذر تشغيل الكود. راجع الصياغة ثم حاول مرة أخرى.';
      _executionTime = executionTime;

      _consoleEntries.add(
        ConsoleEntry(
          text: error,
          type: ConsoleEntryType.error,
        ),
      );
    });
  }

  String _translateCommonError(String message) {
    if (message.contains('is not defined')) {
      return 'يوجد متغير أو دالة تم استخدامها قبل تعريفها.';
    }

    if (message.contains('Unexpected token')) {
      return 'يوجد رمز أو قوس مكتوب بطريقة غير صحيحة.';
    }

    if (message.contains('Unexpected end of input')) {
      return 'تأكد من إغلاق جميع الأقواس وعلامات التنصيص.';
    }

    if (message.contains('already been declared')) {
      return 'تم تعريف المتغير نفسه أكثر من مرة في نفس النطاق.';
    }

    if (message.contains('is not a function')) {
      return 'تحاول تشغيل قيمة ليست دالة.';
    }

    return 'يوجد خطأ في الكود: $message';
  }

  void _resetCode() {
    setState(() {
      _codeController.fullText = widget.exercise.initialCode;
      _consoleEntries.clear();
      _hasExecutionError = false;
      _feedback = null;
      _executionTime = null;
    });
  }

  void _clearEditor() {
    setState(() {
      _codeController.fullText = '';
      _consoleEntries.clear();
      _hasExecutionError = false;
      _feedback = null;
      _executionTime = null;
    });
  }

  void _clearConsole() {
    setState(() {
      _consoleEntries.clear();
      _hasExecutionError = false;
      _feedback = null;
      _executionTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.title,),
        centerTitle: true,
       
        actions: [
          PopupMenuButton<String>(
            tooltip: 'خيارات المحرر',
            onSelected: (value) {
              switch (value) {
                case 'reset':
                  _resetCode();
                  break;
                case 'clear_editor':
                  _clearEditor();
                  break;
                case 'clear_console':
                  _clearConsole();
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'reset',
                child: Row(
                  children: [
                    Icon(Icons.refresh_rounded),
                    SizedBox(width: 10),
                    Text('إعادة الكود الأصلي',),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'clear_editor',
                child: Row(
                  children: [
                    Icon(Icons.code_off_rounded),
                    SizedBox(width: 10),
                    Text('مسح المحرر'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'clear_console',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline_rounded),
                    SizedBox(width: 10),
                    Text('مسح Console'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wideLayout = constraints.maxWidth >= 700;

            if (wideLayout) {
              return Column(
                children: [
                  if (widget.exercise.instructions.trim().isNotEmpty)
                    _buildInstructions(),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: _buildEditorPanel(),
                        ),
                        const VerticalDivider(width: 1),
                        Expanded(
                          flex: 4,
                          child: _buildResultPanel(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                if (widget.exercise.instructions.trim().isNotEmpty)
                  _buildInstructions(),
                Expanded(
                  flex: 6,
                  child: _buildEditorPanel(),
                ),
                Expanded(
                  flex: 4,
                  child: _buildResultPanel(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB)),
        ),
      ),
      child: Text(
        widget.exercise.instructions,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Color(0xFF6B7280),
          fontSize: 14,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildEditorPanel() {
    return Container(
      color: const Color(0xFF191919),
      child: Column(
        children: [
          _PanelHeader(
            title: 'Editor',
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 4,
                  backgroundColor: Color(0xFF22C55E),
                ),
                SizedBox(width: 8),
                Text('JavaScript'),
              ],
            ),
          ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: CodeTheme(
                data: CodeThemeData(
                  styles: atomOneDarkTheme,
                ),
                child: SingleChildScrollView(
                  child: CodeField(
                    controller: _codeController,
                    textStyle: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      height: 1.55,
                    ),
                    gutterStyle: const GutterStyle(
                      showLineNumbers: true,
                      showErrors: true,
                      showFoldingHandles: true,
                      margin: 8,
                      width: 54,
                    ),
                    minLines: 18,
                  ),
                ),
              ),
            ),
          ),
          _buildEditorActions(),
        ],
      ),
    );
  }

  Widget _buildEditorActions() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0xFF11101B),
        border: Border(
          top: BorderSide(color: Color(0xFF29263A)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: _isRunning ? null : _runCode,
              icon: _isRunning
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.play_arrow_rounded),
              label: Text(
                _isRunning ? 'جارٍ التنفيذ...' : 'تشغيل',
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.outlined(
            tooltip: 'مسح Console',
            onPressed: _clearConsole,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
          const SizedBox(width: 8),
          IconButton.outlined(
            tooltip: 'إعادة الكود الأصلي',
            onPressed: _resetCode,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildResultPanel() {
    return Container(
      color: const Color(0xFF080612),
      child: Column(
        children: [
          _PanelHeader(
            title: 'Console — النتيجة',
            trailing: Text(
              _executionTime == null
                  ? '0 ms'
                  : '$_executionTime ms',
            ),
          ),
          if (_feedback != null) _buildFeedback(),
          Expanded(
            child: _consoleEntries.isEmpty
                ? const Center(
                    child: Text(
                      'اكتب أي JavaScript ثم اضغط «تشغيل»',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF71717A),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(14),
                    itemCount: _consoleEntries.length,
                    separatorBuilder: (_, __) =>
                        const Divider(
                          color: Color(0xFF1E1B2E),
                          height: 14,
                        ),
                    itemBuilder: (context, index) {
                      final entry = _consoleEntries[index];

                      return Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          entry.text,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            height: 1.5,
                            color: entry.color,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedback() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _hasExecutionError
            ? const Color(0xFF450A0A)
            : const Color(0xFF052E16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _hasExecutionError
              ? const Color(0xFF991B1B)
              : const Color(0xFF166534),
        ),
      ),
      child: Text(
        _feedback!,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: _hasExecutionError
              ? const Color(0xFFFECACA)
              : const Color(0xFFBBF7D0),
          height: 1.5,
        ),
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader({
    required this.title,
    required this.trailing,
  });

  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        color: Color(0xFF0D0B17),
        border: Border(
          bottom: BorderSide(color: Color(0xFF29263A)),
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFA1A1AA),
              fontSize: 12,
            ),
          ),
          const Spacer(),
          DefaultTextStyle(
            style: const TextStyle(
              color: Color(0xFFA1A1AA),
              fontSize: 12,
            ),
            child: trailing,
          ),
        ],
      ),
    );
  }
}

enum ConsoleEntryType {
  output,
  info,
  warning,
  success,
  error,
}

class ConsoleEntry {
  const ConsoleEntry({
    required this.text,
    required this.type,
  });

  final String text;
  final ConsoleEntryType type;

  Color get color {
    return switch (type) {
      ConsoleEntryType.output => const Color(0xFFE2E8F0),
      ConsoleEntryType.info => const Color(0xFFBFDBFE),
      ConsoleEntryType.warning => const Color(0xFFFDE68A),
      ConsoleEntryType.success => const Color(0xFF86EFAC),
      ConsoleEntryType.error => const Color(0xFFFCA5A5),
    };
  }
}
