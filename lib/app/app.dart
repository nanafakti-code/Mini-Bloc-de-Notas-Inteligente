import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../features/notes/presentation/pages/notes_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Bloc Inteligente',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const NotesListPage(),
    );
  }
}
