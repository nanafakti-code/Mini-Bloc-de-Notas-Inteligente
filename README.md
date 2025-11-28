<div align="center">

# 📝 Mini Bloc de Notas Inteligente

<img src="https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
<img src="https://img.shields.io/badge/Dart-3.9+-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
<img src="https://img.shields.io/badge/SQLite-3.0+-003B57?style=for-the-badge&logo=sqlite&logoColor=white" alt="SQLite"/>
<img src="https://img.shields.io/badge/Riverpod-2.4-FF6B6B?style=for-the-badge&logo=flutter&logoColor=white" alt="Riverpod"/>
<img src="https://img.shields.io/badge/Groq_AI-🤖-FFD700?style=for-the-badge" alt="Groq AI"/>

### 🚀 Aplicación de Notas con IA Integrada

Una aplicación Flutter multiplataforma que permite crear, editar y mejorar notas usando inteligencia artificial de Groq. Incluye validación de caracteres, contador dinámico y análisis en tiempo real.

**[🌐 Características](#-características) • [📋 Requisitos](#-requisitos) • [⚙️ Instalación](#-instalación) • [🔧 Configuración](#-configuración) • [🏗️ Arquitectura](#-arquitectura)**

---

## ✨ Características

### 🎯 Funcionalidades Principales

- ✅ **Crear & Editar Notas** - Interfaz intuitiva para gestionar tus notas
- ✅ **Botón Resumir** - Resume automáticamente contenido con IA (mín. 400 caracteres)
- ✅ **Botón Mejorar** - Mejora gramática, ortografía y estilo con IA
- ✅ **Contador Dinámico** - Caracteres y palabras en tiempo real
- ✅ **Validación Inteligente** - Feedback visual (verde/naranja según umbral)
- ✅ **Base de Datos Local** - SQLite para persistencia sin conexión
- ✅ **Diseño Material 3** - Interfaz moderna con tema oscuro personalizado
- ✅ **Botón Eliminar** - Elimina notas con ícono de papelera
- ✅ **Multiplataforma** - Windows, macOS, Linux, iOS, Android

### 🤖 Inteligencia Artificial

- **Proveedor:** Groq API (completamente gratuito)
- **Modelo:** `llama-3.3-70b-versatile`
- **Velocidad:** Inferencia ultra-rápida
- **Límite:** 30 solicitudes/minuto (plan gratuito)

---

## 📋 Requisitos

### Sistema
- **Flutter:** v3.9.2 o superior
- **Dart:** v3.9.2 o superior
- **Node.js:** v16+ (opcional, para desarrollo web)

### Desarrollo
- Un editor: VS Code, Android Studio o IntelliJ
- Git para control de versiones
- API Key gratuita de Groq (https://console.groq.com/keys)

---

## ⚙️ Instalación

### 1️⃣ Clonar el Repositorio

```bash
git clone https://github.com/nanafakti-code/Mini-Bloc-de-Notas-Inteligente.git
cd Mini-Bloc-de-Notas-Inteligente
```

### 2️⃣ Instalar Dependencias

```bash
flutter pub get
```

### 3️⃣ Obtener API Key (Crucial)

1. Ve a https://console.groq.com/keys
2. Registrate/Inicia sesión (es gratis)
3. Copia tu API Key

### 4️⃣ Configurar Variables de Entorno

En la **raíz del proyecto**, crea un archivo `.env`:

```
GROQ_API_KEY=gsk_tu_api_key_aqui_sin_comillas
```

**⚠️ Nota:** Este archivo no se commitea en Git por seguridad.

### 5️⃣ Ejecutar la Aplicación

```bash
# Listar dispositivos disponibles
flutter devices

# Ejecutar en el dispositivo por defecto
flutter run

# O ejecutar en plataforma específica
flutter run -d windows    # Windows
flutter run -d macos      # macOS
flutter run -d linux      # Linux
```

---

## 🔧 Configuración

### Archivo `.env.example`

```env
# Groq API Configuration
# Obtén tu API key gratis en: https://console.groq.com/keys
GROQ_API_KEY=tu_api_key_aqui_sin_comillas
```

### Variables de Entorno Disponibles

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `GROQ_API_KEY` | API Key de Groq | `gsk_z9VNkVzv...` |

---

## 🏗️ Arquitectura

### 📁 Estructura del Proyecto

```
lib/
├── 📄 main.dart                          # Punto de entrada + configuración
├── 🎨 app/
│   └── app.dart                          # Configuración de la app (temas, rutas)
│
├── ⚙️ core/
│   ├── 🗄️ database/
│   │   ├── app_database.dart             # Inicialización de SQLite
│   │   └── note_dao.dart                 # Data Access Object para notas
│   │
│   ├── 📊 models/
│   │   └── note.dart                     # Modelo de datos (Note entity)
│   │
│   └── 🤖 services/
│       └── ai_service.dart               # Servicio de IA (Groq API)
│
└── 📋 features/
    └── notes/
        ├── 🔄 providers/
        │   └── notes_provider.dart       # Estado global (Riverpod)
        │
        └── 🎯 presentation/
            ├── 📄 pages/
            │   ├── notes_list_page.dart  # Listado de notas
            │   └── note_edit_page.dart   # Crear/editar notas + botones IA
            │
            └── 🧩 widgets/
                ├── note_form.dart        # Formulario reutilizable
                └── note_item.dart        # Card de nota individual
```

### 🔄 Flujo de Datos (Riverpod)

```
notesProvider (StateNotifierProvider)
    ↓
NotesNotifier
    ├── createNote(title, content)
    ├── updateNote(note)
    ├── deleteNote(id)
    └── getNotes() → List<Note>
         ↓
    NoteDAO (Base de datos)
         ↓
    SQLite Database
```

### 🤖 Flujo de IA

```
Usuario escribe nota (400+ caracteres)
         ↓
Toca "Resumir" o "Mejorar"
         ↓
AIService.summarizeText() / improveText()
         ↓
HTTP POST → Groq API
         ↓
Recibe respuesta JSON
         ↓
Dialogo con resultado
         ↓
Usuario puede "Usar resumen" o "Cerrar"
```

### 🗄️ Modelo de Base de Datos

```sql
CREATE TABLE notes (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  createdAt INTEGER NOT NULL,
  updatedAt INTEGER NOT NULL
)
```

### 📦 Dependencias Principales

| Dependencia | Versión | Propósito |
|-------------|---------|----------|
| `flutter_riverpod` | ^2.4.0 | State management |
| `sqflite` | ^2.3.0 | Base de datos local |
| `http` | ^1.1.0 | Llamadas HTTP a Groq |
| `flutter_dotenv` | ^5.1.0 | Variables de entorno |
| `intl` | ^0.18.1 | Internacionalización |

---

## 🚀 Uso

### Crear una Nueva Nota

1. Toca el botón "+" en la AppBar
2. Ingresa un título
3. Escribe el contenido
4. Toca el ícono 💾 para guardar

### Usar IA para Resumir

1. Escribe al menos **400 caracteres**
2. El botón "📊 Resumir" se habilitará (en azul)
3. Toca el botón
4. Espera a que la IA procese (2-5 segundos)
5. Revisa el resumen en el diálogo
6. Toca "Usar resumen" para reemplazar el contenido o "Cerrar"

### Mejorar Texto

1. Escribe cualquier contenido
2. Toca el botón "✏️ Mejorar"
3. Espera la respuesta de IA
4. Toca "Usar texto mejorado" o "Cerrar"

### Eliminar una Nota

1. Toca una nota de la lista
2. En el diálogo, toca el ícono 🗑️ (papelera)
3. Confirma la eliminación

---

## 🎨 Temas y Estilos

### Colores Base
- **Primario:** Azul oscuro (`#1565C0`)
- **Secundario:** Verde (`#4CAF50`)
- **Fondo:** Gris muy oscuro (`#121212`)
- **Superficie:** Gris oscuro (`#1E1E1E`)

### Componentes Estilizados
- AppBar con gradiente
- Cards con bordes redondeados
- Botones con sombras
- Contadores dinámicos con feedback visual

---

## 🔐 Seguridad

### Protección de API Keys

✅ **Lo que hacemos bien:**
- API Keys se guardan en archivo `.env` local
- `.env` está en `.gitignore` (nunca se commitea)
- Validación de API Key en tiempo de ejecución
- Manejo de errores graceful

✅ **Recomendaciones:**
- Nunca compartir tu `.env`
- Regenerar API Key si se expone
- Usar diferentes claves para dev/prod

---

## 🧪 Testing y Desarrollo

### Ejecutar Tests

```bash
flutter test
```

### Análisis de Código

```bash
flutter analyze
```

### Limpiar Build

```bash
flutter clean
flutter pub get
```

### Hot Reload

Durante `flutter run`, presiona:
- **r** - Hot reload
- **R** - Hot restart
- **q** - Quit

---

## 📱 Plataformas Soportadas

| Plataforma | Estado | Requisitos |
|-----------|--------|-----------|
| 🪟 Windows | ✅ Completo | Windows 10+ |
| 🍎 macOS | ✅ Completo | macOS 11+ |
| 🐧 Linux | ✅ Completo | Linux con GTK3+ |
| 📱 Android | ✅ Completo | Android 5.0+ |
| 🍎 iOS | ✅ Completo | iOS 11.0+ |
| 🌐 Web | ⚠️ Parcial | Chrome/Firefox |

---

## 🐛 Solución de Problemas

### Error: "API Key de Groq no configurada"

**Causa:** No existe archivo `.env`

**Solución:**
```bash
# Copiar template
cp .env.example .env

# Editar y añadir tu API Key
nano .env  # o usar tu editor favorito
```

### Error: "HTTP Error 401 - API key inválida"

**Causa:** API Key incorrecta o expirada

**Solución:**
1. Ve a https://console.groq.com/keys
2. Verifica que la key sea correcta
3. Actualiza tu `.env`

### Error: "HTTP Error 429 - Rate limit exceeded"

**Causa:** Superaste el límite de 30 req/minuto

**Solución:** Espera unos minutos antes de intentar de nuevo

### Botón "Resumir" deshabilitado

**Causa:** Texto con menos de 400 caracteres

**Solución:** Escribe más contenido (verás el contador en verde cuando llegues a 400)

---

## 📚 Recursos

- 📖 [Documentación Flutter](https://flutter.dev/docs)
- 🤖 [Consola Groq](https://console.groq.com)
- 📦 [Pub.dev Packages](https://pub.dev)
- 💾 [SQLite Documentación](https://www.sqlite.org/docs.html)
- 🎨 [Material Design 3](https://m3.material.io)

---

## 👥 Autor

Proyecto desarrollado como parte de **DAM 2º - Desarrollo de Interfaces**

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver archivo `LICENSE` para más detalles.

---

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

<div align="center">

### ⭐ Si te fue útil, dale una estrella en GitHub

**Hecho con ❤️ usando Flutter + Groq AI**

[Arriba ⬆️](#mini-bloc-de-notas-inteligente)

</div>

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