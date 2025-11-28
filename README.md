<div align="center">

# 📝 Mini Bloc de Notas Inteligente

<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
<img src="https://img.shields.io/badge/SQLite-07405E?style=for-the-badge&logo=sqlite&logoColor=white" alt="SQLite"/>
<img src="https://img.shields.io/badge/Riverpod-00D9FF?style=for-the-badge&logo=flutter&logoColor=white" alt="Riverpod"/>
<img src="https://img.shields.io/badge/AI_Powered-6366F1?style=for-the-badge&logo=openai&logoColor=white" alt="AI"/>

### 🚀 Una aplicación de notas inteligente con IA integrada

*Gestiona tus notas con el poder de la inteligencia artificial*

[Características](#-características) •
[Requisitos](#-requisitos-previos) •
[Instalación](#-instalación) •
[Configuración](#-configuración-de-ia) •
[Uso](#-uso) •
# Listar dispositivos
flutter devices

# Ejecutar en dispositivo específico
flutter run -d <device-id>
```

### Comandos Útiles

```bash
# Limpiar build
flutter clean

# Reinstalar dependencias
flutter pub get

# Analizar código
flutter analyze

# Ejecutar tests
flutter test
```

---

## 🏗️ Arquitectura

### 📁 Estructura del Proyecto

```
lib/
 ├── 🎯 main.dart                    # Punto de entrada
 ├── 📱 app/
 │    ├── app.dart                   # Configuración de la app
 │    └── router.dart                # Navegación
 ├── 🔧 core/
 │    ├── database/
 │    │     ├── app_database.dart    # Inicialización SQLite
 │    │     └── note_dao.dart        # Operaciones CRUD
 │    ├── models/
 │    │     └── note.dart            # Modelo de datos
 │    └── services/
 │          └── ai_service.dart      # Integración IA
 ├── 🎨 features/
 │    └── notes/
 │         ├── data/
 │         │     └── notes_repository.dart
 │         ├── presentation/
 │         │     ├── pages/
 │         │     │     ├── notes_list_page.dart
 │         │     │     └── note_edit_page.dart
 │         │     └── widgets/
 │         │           ├── note_item.dart
 │         │           └── note_form.dart
 │         └── providers/
 │               └── notes_provider.dart
 ├── 🛠️ utils/
 │     └── helpers.dart
 └── 🎨 config/
       └── theme.dart                # Tema oscuro azulado
```

### 🔄 Flujo de Datos

```
┌─────────────┐
│     UI      │ ← Consume providers
│  (Widgets)  │
└──────┬──────┘
       │
       ↓
┌─────────────┐
│  Riverpod   │ ← Gestión de estado
│  Providers  │
└──────┬──────┘
       │
       ↓
┌─────────────┐
│ Repository  │ ← Lógica de negocio
└──────┬──────┘
       │
       ↓
┌─────────────┐
│  SQLite     │ ← Persistencia
│     DAO     │
└─────────────┘
```

### 🧩 Componentes Principales

#### **Riverpod Providers**

```dart
// Provider para el repositorio
final notesRepositoryProvider = Provider<NotesRepository>(...);

// Provider para la lista de notas
final notesListProvider = StateNotifierProvider<NotesNotifier, AsyncValue<List<Note>>>(...);

// Provider para IA
final aiServiceProvider = Provider<AIService>(...);
```

#### **Base de Datos SQLite**

```sql
CREATE TABLE notes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 🎨 Tema Visual

La aplicación utiliza un esquema de colores oscuro con acentos azulados:

| Color | Hex | Uso |
|-------|-----|-----|
| **Primary** | `#3B82F6` | Botones, acentos |
| **Secondary** | `#1E40AF` | Elementos secundarios |
| **Background** | `#0F172A` | Fondo principal |
| **Surface** | `#1E293B` | Tarjetas, superficies |
| **Accent** | `#60A5FA` | Highlights |

---

## 🤖 Funcionalidades de IA

### Resumir Nota

Genera un resumen conciso del contenido de la nota.

```dart
// Uso interno
final summary = await aiService.summarizeText(noteContent);
```

### Mejorar Texto

Mejora la redacción, gramática y estilo del texto.

```dart
// Uso interno
final improved = await aiService.improveText(noteContent);
```

---

## 📱 Capturas de Pantalla

> 📸 *Próximamente: Capturas de la aplicación en funcionamiento*

---

## 🔍 Solución de Problemas

### ❌ Error: "API key not configured"

**Solución:** Asegúrate de haber configurado tu API key en `.env` o `ai_service.dart`

### ❌ Error: "Database not initialized"

**Solución:** 
```bash
flutter clean
flutter pub get
flutter run
```

### ❌ Error: "No devices found"

**Solución:** Verifica que tu emulador esté ejecutándose o tu dispositivo conectado:
```bash
flutter devices
```

### ❌ La IA no responde

**Solución:** 
1. Verifica tu conexión a internet
2. Comprueba que tu API key sea válida
3. Revisa los logs: `flutter logs`
Este proyecto fue desarrollado como parte de la asignatura **Desarrollo de Interfaces** en **DAM 2º**.

### 📋 División de Trabajo

- **Miembro 1:** Base de datos SQLite y DAO
- **Miembro 2:** Gestión de estado con Riverpod
- **Miembro 3:** Interfaz de usuario y navegación
- **Miembro 4:** Integración de IA y servicios

---

## 📖 Documentación Adicional

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [SQLite Documentation](https://www.sqlite.org/docs.html)
- [Material Design Guidelines](https://material.io/design)

---

## 📄 Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

---

<div align="center">

### 💙 Hecho con Flutter y ❤️

**¿Preguntas o sugerencias?**

[Reportar un Bug](../../issues) • [Solicitar Feature](../../issues) • [Contribuir](CONTRIBUTING.md)

---

⭐ **Si te gusta este proyecto, dale una estrella!** ⭐

</div>