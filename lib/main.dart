import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'users.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT UNIQUE, password TEXT)',
      );
    },
    version: 1,
  );

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Future<Database> database;
  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Demo (SQLite)',
      home: RepositoryProvider(
        create: (_) => UserRepository(database),
        child: BlocProvider(
          create: (context) => AuthCubit(context.read<UserRepository>()),
          child: AuthPage(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UserRepository {
  final Future<Database> database;

  UserRepository(this.database);

  Future<void> registerUser(String name, String email, String password) async {
    final db = await database;
    await db.insert('users', {
      'name': name,
      'email': email,
      'password': password,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> loginUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return maps.isNotEmpty;
  }
}

class AuthCubit extends Cubit<AuthState> {
  final UserRepository repository;
  AuthCubit(this.repository) : super(AuthInitial());

  void register(String name, String email, String password) async {
    try {
      await repository.registerUser(name, email, password);
      emit(AuthSuccess("User registered successfully!"));
    } catch (e) {
      emit(AuthError("Registration failed: ${e.toString()}"));
    }
  }

  void login(String email, String password) async {
    final success = await repository.loginUser(email, password);
    if (success) {
      emit(AuthSuccess("Login successful!"));
    } else {
      emit(AuthError("Invalid email or password"));
    }
  }
}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// Simple AuthPage widget to provide UI for registration and login
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Auth Demo')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  authCubit.register(
                    nameController.text.trim(),
                    emailController.text.trim(),
                    passwordController.text,
                  );
                },
                child: const Text('Register'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  authCubit.login(
                    emailController.text.trim(),
                    passwordController.text,
                  );
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
