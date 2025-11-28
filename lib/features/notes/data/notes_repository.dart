import '../../../core/database/note_dao.dart';
import '../../../core/models/note.dart';

class NotesRepository {
  final NoteDao _noteDao;

  NotesRepository(this._noteDao);

  // Get all notes
  Future<List<Note>> getAllNotes() async {
    try {
      return await _noteDao.getAllNotes();
    } catch (e) {
      throw Exception('Error al obtener las notas: $e');
    }
  }

  // Get note by ID
  Future<Note?> getNoteById(int id) async {
    try {
      return await _noteDao.getNoteById(id);
    } catch (e) {
      throw Exception('Error al obtener la nota: $e');
    }
  }

  // Create new note
  Future<Note> createNote(String title, String content) async {
    try {
      final note = Note(title: title, content: content);
      return await _noteDao.insertNote(note);
    } catch (e) {
      throw Exception('Error al crear la nota: $e');
    }
  }

  // Update existing note
  Future<void> updateNote(Note note) async {
    try {
      await _noteDao.updateNote(note);
    } catch (e) {
      throw Exception('Error al actualizar la nota: $e');
    }
  }

  // Delete note
  Future<void> deleteNote(int id) async {
    try {
      await _noteDao.deleteNote(id);
    } catch (e) {
      throw Exception('Error al eliminar la nota: $e');
    }
  }

  // Get notes count
  Future<int> getNotesCount() async {
    try {
      return await _noteDao.getNotesCount();
    } catch (e) {
      throw Exception('Error al contar las notas: $e');
    }
  }
}
