import 'package:sqflite/sqflite.dart';
import '../models/note.dart';
import 'app_database.dart';

class NoteDao {
  final AppDatabase _database = AppDatabase.instance;

  // Insert a new note
  Future<Note> insertNote(Note note) async {
    final db = await _database.database;
    final id = await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return note.copyWith(id: id);
  }

  // Get all notes ordered by updated_at descending
  Future<List<Note>> getAllNotes() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      orderBy: 'updated_at DESC',
    );

    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  // Get a single note by ID
  Future<Note?> getNoteById(int id) async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }

    return Note.fromMap(maps.first);
  }

  // Update an existing note
  Future<int> updateNote(Note note) async {
    final db = await _database.database;
    return await db.update(
      'notes',
      note.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // Delete a note
  Future<int> deleteNote(int id) async {
    final db = await _database.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // Delete all notes (useful for testing)
  Future<int> deleteAllNotes() async {
    final db = await _database.database;
    return await db.delete('notes');
  }

  // Get notes count
  Future<int> getNotesCount() async {
    final db = await _database.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM notes');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
