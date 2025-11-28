import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/note.dart';
import '../../providers/notes_provider.dart';
import '../widgets/note_form.dart';

class NoteEditPage extends ConsumerStatefulWidget {
  final Note? note;

  const NoteEditPage({super.key, this.note});

  @override
  ConsumerState<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends ConsumerState<NoteEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isLoading = false;
  bool _hasChanges = false;
  static const int _minCharactersToSummarize = 400;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );

    // Listen for changes - rebuild on every change to update counters
    _titleController.addListener(() {
      _onTextChanged();
      setState(() {});
    });
    _contentController.addListener(() {
      _onTextChanged();
      setState(() {}); // Rebuild to update character/word counters
    });
  }

  void _onTextChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.note == null) {
        // Create new note
        await ref
            .read(notesProvider.notifier)
            .createNote(
              _titleController.text.trim(),
              _contentController.text.trim(),
            );
      } else {
        // Update existing note
        final updatedNote = widget.note!.copyWith(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
        );
        await ref.read(notesProvider.notifier).updateNote(updatedNote);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.note == null ? 'Nota creada' : 'Nota actualizada',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _summarizeNote() async {
    final contentLength = _contentController.text.trim().length;

    if (contentLength < _minCharactersToSummarize) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'El texto debe tener al menos $_minCharactersToSummarize caracteres para resumir (actualmente tiene $contentLength)',
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final aiService = ref.read(aiServiceProvider);
      final summary = await aiService.summarizeText(_contentController.text);

      if (mounted) {
        // Check if IA couldn't summarize (common phrases indicating no resumable content)
        final cannotSummarize = summary.toLowerCase().contains('no hay texto que resumir') ||
            summary.toLowerCase().contains('no contiene suficiente información') ||
            summary.toLowerCase().contains('demasiado corto') ||
            summary.toLowerCase().contains('texto proporcionado es muy corto') ||
            summary.toLowerCase().contains('no hay contenido suficiente');

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.blue),
                SizedBox(width: 8),
                Text('Resumen IA'),
              ],
            ),
            content: SingleChildScrollView(child: Text(summary)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
              if (!cannotSummarize)
                ElevatedButton(
                  onPressed: () {
                    _contentController.text = summary;
                    Navigator.pop(context);
                  },
                  child: const Text('Usar resumen'),
                ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al resumir: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _improveText() async {
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay contenido para mejorar')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final aiService = ref.read(aiServiceProvider);
      final improved = await aiService.improveText(_contentController.text);

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.auto_fix_high, color: Colors.green),
                SizedBox(width: 8),
                Text('Texto Mejorado'),
              ],
            ),
            content: SingleChildScrollView(child: Text(improved)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
              ElevatedButton(
                onPressed: () {
                  _contentController.text = improved;
                  Navigator.pop(context);
                },
                child: const Text('Usar texto mejorado'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al mejorar texto: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            widget.note == null ? 'Nueva Nota' : 'Editar Nota',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveNote,
              tooltip: 'Guardar',
            ),
        ],
      ),
      body: Column(
        children: [
          // AI Actions Bar
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Character and word counter
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_contentController.text.length} caracteres',
                        style: TextStyle(
                          fontSize: 12,
                          color: _contentController.text.length >= _minCharactersToSummarize
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${_contentController.text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length} palabras',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Mínimo: $_minCharactersToSummarize caracteres',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isLoading || _contentController.text.trim().length < _minCharactersToSummarize
                            ? null
                            : _summarizeNote,
                        icon: const Icon(Icons.auto_awesome, size: 18),
                        label: const Text('Resumir'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _improveText,
                        icon: const Icon(Icons.auto_fix_high, size: 18),
                        label: const Text('Mejorar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Note Form
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: NoteForm(
                titleController: _titleController,
                contentController: _contentController,
                formKey: _formKey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
