import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/chat_message.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('aether_chat.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Table for messages
    await db.execute('''
      CREATE TABLE messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL,
        isUser INTEGER NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
    
    // Table for settings (like sessionId)
    await db.execute('''
      CREATE TABLE settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
  }

  // Session ID Methods
  Future<void> saveSessionId(String id) async {
    final db = await instance.database;
    await db.insert('settings', {'key': 'sessionId', 'value': id},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getSessionId() async {
    final db = await instance.database;
    final maps = await db.query('settings', where: 'key = ?', whereArgs: ['sessionId']);
    if (maps.isNotEmpty) return maps.first['value'] as String;
    return null;
  }

  // Message Methods
  Future<void> insertMessage(ChatMessage message) async {
    final db = await instance.database;
    await db.insert('messages', {
      'text': message.text,
      'isUser': message.isUser ? 1 : 0,
      'timestamp': message.timestamp.toIso8601String(),
    });
  }

  Future<List<ChatMessage>> getAllMessages() async {
    final db = await instance.database;
    final result = await db.query('messages', orderBy: 'timestamp DESC');

    return result.map((map) => ChatMessage(
      text: map['text'] as String,
      isUser: map['isUser'] == 1,
      timestamp: DateTime.parse(map['timestamp'] as String),
    )).toList();
  }
}