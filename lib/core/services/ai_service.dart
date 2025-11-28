import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  // IMPORTANT: Configure your API key here or use environment variables
  static const String _apiKey = 'YOUR_API_KEY_HERE';

  // Choose your AI provider: 'openai', 'gemini', or 'claude'
  static const String _provider = 'openai';

  // API endpoints
  static const String _openaiEndpoint =
      'https://api.openai.com/v1/chat/completions';
  static const String _geminiEndpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  // Summarize text using AI
  Future<String> summarizeText(String text) async {
    if (text.isEmpty) {
      throw Exception('El texto no puede estar vacío');
    }

    if (_apiKey == 'YOUR_API_KEY_HERE') {
      // Return mock response if API key is not configured
      return _getMockSummary(text);
    }

    try {
      final prompt =
          'Resume el siguiente texto de forma concisa y clara:\n\n$text';
      return await _callAI(prompt);
    } catch (e) {
      throw Exception('Error al resumir el texto: $e');
    }
  }

  // Improve text using AI
  Future<String> improveText(String text) async {
    if (text.isEmpty) {
      throw Exception('El texto no puede estar vacío');
    }

    if (_apiKey == 'YOUR_API_KEY_HERE') {
      // Return mock response if API key is not configured
      return _getMockImprovement(text);
    }

    try {
      final prompt =
          'Mejora el siguiente texto corrigiendo gramática, estilo y claridad. Mantén el mismo significado:\n\n$text';
      return await _callAI(prompt);
    } catch (e) {
      throw Exception('Error al mejorar el texto: $e');
    }
  }

  // Call AI API based on provider
  Future<String> _callAI(String prompt) async {
    switch (_provider) {
      case 'openai':
        return await _callOpenAI(prompt);
      case 'gemini':
        return await _callGemini(prompt);
      default:
        throw Exception('Proveedor de IA no soportado: $_provider');
    }
  }

  // OpenAI API call
  Future<String> _callOpenAI(String prompt) async {
    final response = await http.post(
      Uri.parse(_openaiEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        'max_tokens': 500,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception(
        'Error de API: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // Google Gemini API call
  Future<String> _callGemini(String prompt) async {
    final url = '$_geminiEndpoint?key=$_apiKey';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt},
            ],
          },
        ],
        'generationConfig': {'temperature': 0.7, 'maxOutputTokens': 500},
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'].trim();
    } else {
      throw Exception(
        'Error de API: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // Mock responses for testing without API key
  String _getMockSummary(String text) {
    return '📝 RESUMEN (Demo):\n\n'
        'Este es un resumen simulado de tu nota. '
        'Para obtener resúmenes reales generados por IA, configura tu API key en el archivo ai_service.dart.\n\n'
        'Texto original: ${text.length} caracteres\n'
        'Resumen: ${(text.length * 0.3).round()} caracteres aproximadamente';
  }

  String _getMockImprovement(String text) {
    return '✨ TEXTO MEJORADO (Demo):\n\n'
        '$text\n\n'
        '---\n'
        'Este es un texto de demostración. '
        'Para obtener mejoras reales generadas por IA, configura tu API key en el archivo ai_service.dart.';
  }

  // Check if API is configured
  bool get isConfigured => _apiKey != 'YOUR_API_KEY_HERE';
}
