import 'package:flutter/material.dart';
import '../../../../utils/helpers.dart';

class NoteForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final GlobalKey<FormState> formKey;

  const NoteForm({
    super.key,
    required this.titleController,
    required this.contentController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Title field
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Título',
              hintText: 'Ingresa el título de la nota',
              prefixIcon: Icon(Icons.title),
            ),
            style: Theme.of(context).textTheme.titleLarge,
            textCapitalization: TextCapitalization.sentences,
            validator: ValidationHelper.validateTitle,
            maxLength: 100,
          ),
          const SizedBox(height: 16),

          // Content field
          Expanded(
            child: TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Contenido',
                hintText: 'Escribe el contenido de tu nota aquí...',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 200),
                  child: Icon(Icons.notes),
                ),
                alignLabelWithHint: true,
              ),
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              textCapitalization: TextCapitalization.sentences,
              validator: ValidationHelper.validateContent,
            ),
          ),

          // Character and word count
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${TextHelper.wordCount(contentController.text)} palabras · '
                  '${contentController.text.length} caracteres',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
