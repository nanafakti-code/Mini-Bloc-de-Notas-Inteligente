import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/note_dao.dart';
import '../../../core/models/note.dart';
import '../../../core/services/ai_service.dart';
import '../data/notes_repository.dart';

// Provider for NoteDao
final noteDaoProvider = Provider<NoteDao>((ref) {
  return NoteDao();
});

// Provider for NotesRepository
final notesRepositoryProvider = Provider<NotesRepository>((ref) {
  final noteDao = ref.watch(noteDaoProvider);
  return NotesRepository(noteDao);
});

// Provider for AIService
final aiServiceProvider = Provider<AIService>((ref) {
  return AIService();
});

// StateNotifier for managing notes list
class NotesNotifier extends StateNotifier<AsyncValue<List<Note>>> {
  final NotesRepository _repository;

  NotesNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadNotes();
  }

  // Load all notes
  Future<void> loadNotes() async {
    state = const AsyncValue.loading();
    try {
      final notes = await _repository.getAllNotes();
      state = AsyncValue.data(notes);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Create a new note
  Future<void> createNote(String title, String content) async {
    try {
      await _repository.createNote(title, content);
      await loadNotes(); // Reload to update UI
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Update an existing note
  Future<void> updateNote(Note note) async {
    try {
      await _repository.updateNote(note);
      await loadNotes(); // Reload to update UI
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Delete a note
  Future<void> deleteNote(int id) async {
    try {
      await _repository.deleteNote(id);
      await loadNotes(); // Reload to update UI
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Refresh notes (for pull-to-refresh)
  Future<void> refresh() async {
    await loadNotes();
  }
}

// Provider for NotesNotifier
final notesProvider =
    StateNotifierProvider<NotesNotifier, AsyncValue<List<Note>>>((ref) {
      final repository = ref.watch(notesRepositoryProvider);
      return NotesNotifier(repository);
    });
