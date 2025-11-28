# Configuración de Google Gemini API

## 📋 Requisitos Previos

- Tener una cuenta de Google
- Acceso a [Google AI Studio](https://ai.google.dev/)

## 🔑 Pasos para Obtener la API Key

### 1. Ir a Google AI Studio
Ve a: https://ai.google.dev/

### 2. Crear una API Key
- Click en **"Get API Key"** o **"Create API Key"**
- Si es tu primera vez, Google te pedirá que habilites la API de Gemini
- Haz click en **"Create API Key in new project"**

### 3. Copiar la API Key
- Se te mostrará tu nueva API key
- Cópiala (es una cadena larga de caracteres)

## 🔧 Configuración en la App

### Opción 1: Configuración Directa (Solo Desarrollo)

Abre el archivo `lib/core/services/ai_service.dart` y reemplaza:

```dart
static const String _apiKey = 'YOUR_GEMINI_API_KEY_HERE';
```

Por tu API key real:

```dart
static const String _apiKey = 'AIzaSyD_...tu_key_aqui...';
```

⚠️ **IMPORTANTE**: No subas tu API key real a GitHub. Esto es solo para desarrollo local.

### Opción 2: Variables de Entorno (Recomendado)

Si quieres mayor seguridad, usa variables de entorno. Crea un archivo `.env` en la raíz del proyecto:

```env
GEMINI_API_KEY=AIzaSyD_...tu_key_aqui...
```

Luego usa el package `flutter_dotenv` para cargarla:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY');
```

## ✅ Probar la Configuración

1. Ejecuta la app: `flutter run`
2. Crea una nueva nota
3. Escribe algo de contenido
4. Haz click en el botón **"Resumir"** o **"Mejorar"**
5. Si la API key está configurada correctamente, verás resultados reales de Gemini

Si la API key no está configurada, verás respuestas de demostración.

## 🛡️ Seguridad

- **NUNCA** subas tu API key real a GitHub
- Si accidentalmente la subiste, revócala inmediatamente en Google AI Studio
- Considera usar un servicio backend para las llamadas a Gemini en producción

## 📚 Recursos Útiles

- [Documentación de Gemini API](https://ai.google.dev/docs)
- [Guía de Primeros Pasos](https://ai.google.dev/tutorials/python_quickstart)
- [Límites de Uso](https://ai.google.dev/pricing)

## ❓ Solución de Problemas

### Error 401: Unauthorized
- Verifica que tu API key sea correcta
- Asegúrate de haber copiado toda la cadena sin espacios

### Error 429: Too Many Requests
- Has superado el límite de solicitudes
- Espera un tiempo antes de volver a intentar
- Considera un plan de pago si necesitas más solicitudes

### Error 500: Internal Server Error
- Es un problema del servidor de Google
- Intenta de nuevo más tarde

---

**Nota**: Google Gemini ofrece un plan gratuito con límite de solicitudes. Para producción, considera un plan de pago.
