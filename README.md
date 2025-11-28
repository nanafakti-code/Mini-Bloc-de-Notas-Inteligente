# 📝 Mini Bloc de Notas Inteligente

Una aplicación Flutter de notas con inteligencia artificial integrada usando Groq API.

## ✨ Características

- ✅ Crear, editar y eliminar notas
- ✅ Resumir texto con IA (mínimo 400 caracteres)
- ✅ Mejorar gramática y ortografía con IA
- ✅ Contador de caracteres y palabras en tiempo real
- ✅ Base de datos local con SQLite
- ✅ Interfaz moderna con Material Design 3
- ✅ Multiplataforma: Windows, macOS, Linux, iOS, Android

## 🚀 Inicio Rápido

### 1. Clonar el repositorio

```bash
git clone https://github.com/nanafakti-code/Mini-Bloc-de-Notas-Inteligente.git
cd Mini-Bloc-de-Notas-Inteligente
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Configurar API Key de Groq

1. Ve a https://console.groq.com/keys
2. Crea una cuenta gratis y obtén tu API Key
3. En la raíz del proyecto, crea un archivo `.env`:

```
GROQ_API_KEY=tu_api_key_aqui
```

### 4. Ejecutar la aplicación

```bash
flutter run
```

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada
├── app.dart                     # Configuración de la app
├── app/                         # Configuración de temas y rutas
├── core/
│   ├── database/               # SQLite
│   ├── models/                 # Modelos de datos
│   └── services/               # Servicio de IA
├── features/notes/
│   ├── providers/              # Estado (Riverpod)
│   └── presentation/
│       ├── pages/              # Pantallas
│       └── widgets/            # Componentes
└── utils/                       # Funciones auxiliares
```

## 🤖 Cómo usar la IA

### Resumir una nota
1. Escribe **al menos 400 caracteres**
2. Toca el botón **"Resumir"** (se habilita en azul)
3. Espera 2-5 segundos
4. Toca **"Usar resumen"** para aplicar o **"Cerrar"**

### Mejorar texto
1. Escribe contenido en la nota
2. Toca el botón **"Mejorar"** (en verde)
3. Espera la respuesta
4. Toca **"Usar texto mejorado"** o **"Cerrar"**

## 📊 Tecnologías

- **Flutter** - Framework UI
- **Dart** - Lenguaje de programación
- **Riverpod** - Gestión de estado
- **SQLite** - Base de datos local
- **Groq API** - Inteligencia artificial (gratis)
- **flutter_dotenv** - Variables de entorno

## 🔐 Seguridad

- El archivo `.env` con tu API Key **NO se commitea** en Git
- Está protegido en `.gitignore`
- Cada desarrollador debe crear su propio `.env`

## ⚙️ Comandos útiles

```bash
# Limpiar proyecto
flutter clean

# Reinstalar dependencias
flutter pub get

# Analizar código
flutter analyze

# Ejecutar tests
flutter test

# Ejecutar en dispositivo específico
flutter run -d <device-id>
```

## 🐛 Solución de problemas

### "API Key de Groq no configurada"
- Crea un archivo `.env` en la raíz del proyecto
- Añade: `GROQ_API_KEY=tu_clave_aqui`

### "Botón Resumir deshabilitado"
- Escribe al menos 400 caracteres (verás un contador verde)

### "Error 401 - API key inválida"
- Verifica tu API Key en https://console.groq.com/keys
- Actualiza el archivo `.env`

### "Error 429 - Límite de solicitudes"
- Espera unos minutos antes de intentar de nuevo
- Plan gratuito: 30 solicitudes por minuto

## 📱 Plataformas soportadas

| Plataforma | Estado |
|-----------|--------|
| Windows   | ✅     |
| macOS     | ✅     |
| Linux     | ✅     |
| Android   | ✅     |
| iOS       | ✅     |
| Web       | ⚠️     |

## 📚 Requisitos

- Flutter 3.9.2+
- Dart 3.9.2+
- API Key gratis de Groq

## 📖 Documentación

- [Configuración detallada](./CONFIGURACION_IA.md)
- [Flutter Docs](https://flutter.dev)
- [Groq API](https://console.groq.com)

## 👨‍💻 Autor

Desarrollado como proyecto del curso **DAM 2º - Desarrollo de Interfaces**

## 📄 Licencia

MIT License - Ver archivo LICENSE para más detalles

---

**¿Preguntas?** Crea un Issue en el repositorio.

⭐ **Si te fue útil, dale una estrella en GitHub!**
