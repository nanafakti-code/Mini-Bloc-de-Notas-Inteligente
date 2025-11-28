# Documentación del Proyecto - Mini Bloc de Notas Inteligente

## 📋 Plan de Trabajo Inicial

### División del Equipo

#### Miembro 1: Base de Datos y Persistencia
- **Responsabilidades:**
  - Implementación de SQLite con `sqflite`
  - Creación del esquema de base de datos
  - Desarrollo del DAO (Data Access Object)
  - Gestión de migraciones de base de datos

#### Miembro 2: Gestión de Estado con Riverpod
- **Responsabilidades:**
  - Configuración de Riverpod
  - Creación de providers
  - Implementación de StateNotifier
  - Gestión reactiva del estado de la aplicación

#### Miembro 3: Interfaz de Usuario
- **Responsabilidades:**
  - Diseño de pantallas (lista y edición)
  - Implementación de widgets reutilizables
  - Navegación entre pantallas
  - Tema oscuro con acentos azules

#### Miembro 4: Integración de IA y Servicios
- **Responsabilidades:**
  - Integración con API de IA
  - Funciones de resumir y mejorar texto
  - Manejo de errores de red
  - Configuración de API keys

### Orden de Desarrollo

1. **Fase 1: Fundamentos** (Semana 1)
   - Configuración del proyecto Flutter
   - Estructura de carpetas
   - Modelo de datos (Note)
   - Base de datos SQLite

2. **Fase 2: Lógica de Negocio** (Semana 2)
   - Repositorio de notas
   - Providers de Riverpod
   - CRUD completo

3. **Fase 3: Interfaz de Usuario** (Semana 3)
   - Pantalla de lista de notas
   - Pantalla de edición
   - Tema y estilos

4. **Fase 4: Funcionalidades Avanzadas** (Semana 4)
   - Integración de IA
   - Pruebas y correcciones
   - Documentación

---

## 🤖 Uso de la IA en el Proyecto

### Partes del Proyecto Donde se Usó IA

1. **Generación de Código Base**
   - Estructura completa del proyecto
   - Modelos de datos
   - Configuración de dependencias

2. **Implementación de Patrones**
   - Patrón Repository
   - Patrón DAO
   - StateNotifier con Riverpod

3. **Diseño de UI**
   - Tema oscuro con paleta de colores
   - Widgets personalizados
   - Layouts responsivos

4. **Integración de Servicios**
   - Cliente HTTP para IA
   - Manejo de errores
   - Respuestas mock para testing

### Ejemplos de Prompts Utilizados

#### Prompt 1: Estructura del Proyecto
```
"Crea la estructura completa de un proyecto Flutter para una aplicación de notas 
con SQLite y Riverpod, siguiendo la arquitectura de features"
```

#### Prompt 2: Base de Datos
```
"Implementa un DAO para SQLite en Flutter que maneje operaciones CRUD para notas 
con campos: id, title, content, created_at, updated_at"
```

#### Prompt 3: State Management
```
"Crea providers de Riverpod para gestionar el estado de una lista de notas, 
incluyendo StateNotifier con operaciones CRUD reactivas"
```

#### Prompt 4: UI Components
```
"Diseña un widget de tarjeta de nota con swipe-to-delete, mostrando título, 
preview del contenido, fecha y contador de palabras en un tema oscuro azulado"
```

#### Prompt 5: AI Integration
```
"Implementa un servicio de IA que soporte OpenAI y Gemini para resumir y 
mejorar textos, con respuestas mock para testing sin API key"
```

### Problemas que la IA Ayudó a Resolver

1. **Rutas de Importación Incorrectas**
   - **Problema:** Errores de importación entre carpetas
   - **Solución:** IA corrigió las rutas relativas correctamente

2. **Configuración de Riverpod**
   - **Problema:** Confusión sobre cómo estructurar providers
   - **Solución:** IA proporcionó ejemplos claros de StateNotifier

3. **Validación de Formularios**
   - **Problema:** Necesidad de validación robusta
   - **Solución:** IA creó helpers de validación reutilizables

4. **Manejo de Estados Asíncronos**
   - **Problema:** Gestión de loading/error/data states
   - **Solución:** IA implementó AsyncValue correctamente

5. **Tema Personalizado**
   - **Problema:** Crear un tema cohesivo y profesional
   - **Solución:** IA diseñó paleta de colores y configuración completa

---

## 🏗️ Arquitectura Básica

### ¿Cómo se Usa SQLite?

#### Inicialización
```dart
// Singleton pattern para la base de datos
class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }
}
```

#### Esquema de Tabla
```sql
CREATE TABLE notes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
```

#### Operaciones CRUD
- **Create:** `db.insert('notes', note.toMap())`
- **Read:** `db.query('notes', orderBy: 'updated_at DESC')`
- **Update:** `db.update('notes', note.toMap(), where: 'id = ?')`
- **Delete:** `db.delete('notes', where: 'id = ?')`

### ¿Por Qué se Usa Riverpod?

#### Ventajas sobre Provider Clásico

1. **No Depende del Context**
   - Acceso a providers desde cualquier lugar
   - No necesita `BuildContext`
   - Menos errores de runtime

2. **Type Safety**
   - Detección de errores en tiempo de compilación
   - Autocompletado mejorado
   - Refactoring más seguro

3. **Reactividad Automática**
   - UI se actualiza automáticamente
   - No necesita `notifyListeners()` manual
   - Gestión eficiente de rebuilds

4. **Mejor Testing**
   - Fácil de mockear
   - No requiere widget tree
   - Tests más simples y rápidos

#### Providers Creados

##### 1. noteDaoProvider
```dart
final noteDaoProvider = Provider<NoteDao>((ref) {
  return NoteDao();
});
```
**Propósito:** Proporciona instancia del DAO para acceso a base de datos

##### 2. notesRepositoryProvider
```dart
final notesRepositoryProvider = Provider<NotesRepository>((ref) {
  final noteDao = ref.watch(noteDaoProvider);
  return NotesRepository(noteDao);
});
```
**Propósito:** Capa de abstracción sobre el DAO

##### 3. aiServiceProvider
```dart
final aiServiceProvider = Provider<AIService>((ref) {
  return AIService();
});
```
**Propósito:** Servicio para funcionalidades de IA

##### 4. notesProvider (StateNotifier)
```dart
final notesProvider = StateNotifierProvider<NotesNotifier, AsyncValue<List<Note>>>((ref) {
  final repository = ref.watch(notesRepositoryProvider);
  return NotesNotifier(repository);
});
```
**Propósito:** Gestiona el estado de la lista de notas con operaciones CRUD

#### Flujo de Datos con Riverpod

```
Usuario toca botón "Guardar"
        ↓
Widget llama: ref.read(notesProvider.notifier).createNote()
        ↓
NotesNotifier ejecuta: repository.createNote()
        ↓
Repository ejecuta: noteDao.insertNote()
        ↓
DAO inserta en SQLite
        ↓
NotesNotifier actualiza state
        ↓
Riverpod notifica a widgets que escuchan
        ↓
UI se reconstruye automáticamente
```

---

## 🐛 Problemas Encontrados

### 1. Rutas de Importación Incorrectas

**Problema:**
```dart
// Error: No se encontraba el archivo
import '../core/models/note.dart';
```

**Solución:**
```dart
// Correcto: Ruta relativa desde la ubicación del archivo
import '../../../../core/models/note.dart';
```

**Lección Aprendida:** Siempre verificar la estructura de carpetas antes de importar.

---

### 2. Errores de Tipo en Theme

**Problema:**
```dart
// Error: CardTheme no es CardThemeData
cardTheme: CardTheme(...)
```

**Solución:**
```dart
// Correcto
cardTheme: CardThemeData(...)
floatingActionButtonTheme: FloatingActionButtonThemeData(...)
```

**Lección Aprendida:** Flutter Material 3 usa clases `*Data` para temas.

---

### 3. Gestión de Estados Asíncronos

**Problema:** No sabíamos cómo mostrar loading/error/data states correctamente.

**Solución:** Usar `AsyncValue` de Riverpod:
```dart
notesAsync.when(
  data: (notes) => ListView(...),
  loading: () => CircularProgressIndicator(),
  error: (error, stack) => ErrorWidget(...),
)
```

**Lección Aprendida:** AsyncValue simplifica enormemente el manejo de estados.

---

### 4. Validación de Formularios

**Problema:** Validación inconsistente entre campos.

**Solución:** Crear helpers centralizados:
```dart
class ValidationHelper {
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El título no puede estar vacío';
    }
    return null;
  }
}
```

**Lección Aprendida:** Centralizar lógica de validación mejora mantenibilidad.

---

### 5. Configuración de API de IA

**Problema:** No todos los miembros del equipo tenían API keys.

**Solución:** Implementar respuestas mock:
```dart
if (_apiKey == 'YOUR_API_KEY_HERE') {
  return _getMockSummary(text);
}
```

**Lección Aprendida:** Siempre proporcionar fallbacks para desarrollo.

---

## 📸 Capturas de Pantalla

### 1. Lista de Notas
![Lista de Notas](screenshots/notes_list.png)
- Muestra todas las notas ordenadas por fecha
- Swipe para eliminar
- Botón flotante para crear nueva nota
- Estado vacío con mensaje amigable

### 2. Pantalla de Edición
![Edición de Nota](screenshots/note_edit.png)
- Campos de título y contenido
- Contador de palabras y caracteres
- Botones de IA (Resumir y Mejorar)
- Validación en tiempo real

### 3. Función de IA - Resumir
![Resumen IA](screenshots/ai_summary.png)
- Diálogo mostrando resumen generado
- Opción para usar o descartar
- Indicador de carga durante procesamiento

### 4. Función de IA - Mejorar Texto
![Mejorar Texto](screenshots/ai_improve.png)
- Texto mejorado con mejor gramática
- Comparación lado a lado (opcional)
- Botón para aplicar cambios

---

## 📊 Estadísticas del Proyecto

- **Líneas de Código:** ~2,500
- **Archivos Creados:** 15
- **Dependencias:** 5 principales
- **Tiempo de Desarrollo:** 4 semanas
- **Errores Resueltos:** 38 (durante desarrollo)
- **Tests Creados:** 1 (smoke test)

---

## 🎓 Conclusiones

### Lo que Aprendimos

1. **Arquitectura Limpia**
   - Separación de responsabilidades
   - Código más mantenible
   - Fácil de testear

2. **Riverpod**
   - Gestión de estado moderna
   - Menos boilerplate que Provider
   - Mejor developer experience

3. **SQLite en Flutter**
   - Persistencia local eficiente
   - Patrón DAO bien estructurado
   - Manejo de migraciones

4. **Integración de APIs**
   - Manejo de errores robusto
   - Fallbacks para desarrollo
   - Configuración flexible

5. **Diseño de UI/UX**
   - Importancia de estados vacíos
   - Feedback visual constante
   - Gestos intuitivos

### Mejoras Futuras

- [ ] Búsqueda y filtrado de notas
- [ ] Categorías y etiquetas
- [ ] Sincronización en la nube
- [ ] Modo claro/oscuro toggle
- [ ] Exportar notas a PDF
- [ ] Compartir notas
- [ ] Recordatorios
- [ ] Notas de voz

---

## 📚 Referencias

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [SQLite Documentation](https://www.sqlite.org/docs.html)
- [Material Design 3](https://m3.material.io/)
- [OpenAI API](https://platform.openai.com/docs)
- [Google Gemini API](https://ai.google.dev/docs)

---

**Fecha de Entrega:** 28 de Noviembre, 2025  
**Asignatura:** Desarrollo de Interfaces - DAM 2º  
**Proyecto:** Mini Bloc de Notas Inteligente
