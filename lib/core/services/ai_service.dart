import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  // Groq API - COMPLETAMENTE GRATUITO y funcional
  // Obtén tu API key gratis en: https://console.groq.com/
  static const String _groqEndpoint = 'https://api.groq.com/openai/v1/chat/completions';
  
  // Lee la API Key desde el archivo .env o variables de entorno
  // Para desarrollo local, crea un archivo .env en la raíz del proyecto
  // Para producción, configura GROQ_API_KEY en las variables de entorno
  static String get _apiKey {
    final apiKey = dotenv.env['GROQ_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception(
        'API Key de Groq no configurada. '
        'Por favor, crea un archivo .env con GROQ_API_KEY=tu_clave_aqui'
      );
    }
    return apiKey;
  }

  // Summarize text using AI
  Future<String> summarizeText(String text) async {
    if (text.isEmpty) {
      throw Exception('El texto no puede estar vacío');
    }

    try {
      final prompt =
          'Resume el siguiente texto de forma concisa en 2-3 párrafos, manteniendo los puntos principales:\n\n$text';
      return await _callGroq(prompt);
    } catch (e) {
      print('Error en Groq: $e');
      rethrow;
    }
  }

  // Improve text using AI
  Future<String> improveText(String text) async {
    if (text.isEmpty) {
      throw Exception('El texto no puede estar vacío');
    }

    try {
      final prompt =
          'Mejora el siguiente texto: corrige gramática, puntuación, ortografía y estilo. Mantén el significado original pero hazlo más claro y profesional. Solo devuelve el texto mejorado:\n\n$text';
      return await _callGroq(prompt);
    } catch (e) {
      print('Error en Groq: $e');
      rethrow;
    }
  }

  // Groq API call - Completamente gratis y rápido
  Future<String> _callGroq(String prompt) async {
    try {
      print('Llamando a Groq API...');
      
      final response = await http.post(
        Uri.parse(_groqEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'llama-3.3-70b-versatile', // Modelo más nuevo de Groq
          'messages': [
            {
              'role': 'user',
              'content': prompt,
            }
          ],
          'temperature': 0.7,
          'max_tokens': 1024,
        }),
      ).timeout(const Duration(seconds: 30));

      print('Groq Response Status: ${response.statusCode}');
      print('Groq Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          final content = data['choices'][0]['message']['content'];
          if (content != null) {
            return content.toString().trim();
          }
        }
        
        throw Exception('Respuesta vacía de Groq');
      } else if (response.statusCode == 401) {
        throw Exception('API key inválida. Obtén tu clave GRATIS en: https://console.groq.com/keys');
      } else if (response.statusCode == 429) {
        throw Exception('Has superado el límite de solicitudes. Intenta más tarde.');
      } else if (response.statusCode == 500 || response.statusCode == 503) {
        throw Exception('Error en el servidor de Groq. Intenta más tarde.');
      } else {
        throw Exception('Error ${response.statusCode}: ${response.body}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Error de conexión: ${e.message}. Verifica tu conexión a internet.');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
