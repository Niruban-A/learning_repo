import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// --- Data Model ---
class Task {
  final String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

// --- Main App Widget ---
void main() {
  runApp(const GamifiedTodoApp());
}

class GamifiedTodoApp extends StatelessWidget {
  const GamifiedTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Level Up Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoScreen(),
    );
  }
}

// --- Todo Screen ---
class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // List of tasks
  final List<Task> _tasks = [
    Task(title: 'Finish Flutter Setup'),
    Task(title: 'Design Level Up Logic'),
    Task(title: 'Integrate Rive Animation'),
    Task(title: 'Practice Dart Async/Await'),
    Task(title: 'Review Project Requirements'),
    Task(title: 'Test Level 2 Trigger'),
    Task(title: 'Add New Feature Idea'),
  ];

  int _completedCount = 0;
  int _level = 1;
  static const int tasksPerLevel = 3; // Define how many tasks unlock a new level

  // --- Rive Controller and Input ---
  StateMachineController? _riveController;
  SMIInput<double>? _levelInput;
  SMIInput<bool>? _celebrationTrigger;

  @override
  void initState() {
    super.initState();
    _updateMetrics();
  }

  // Called when the Rive file is loaded
  void _onRiveInit(Artboard artboard) {
    // Find the State Machine we expect in the Rive file
    _riveController = StateMachineController.fromArtboard(
      artboard,
      'LevelController', // MUST match the name of your State Machine in Rive
    );

    if (_riveController != null) {
      artboard.addController(_riveController!);
      // Find the inputs we expect
      _levelInput = _riveController!.findInput<double>('Level'); // MUST match the name of your Number Input in Rive
      _celebrationTrigger = _riveController!.findInput<bool>('Celebrate'); // MUST match the name of your Boolean Input (Trigger) in Rive

      // Set the initial level
      _levelInput?.value = _level.toDouble();
      setState(() {});
    }
  }

  // Calculates the current level and completed count
  void _updateMetrics() {
    _completedCount = _tasks.where((task) => task.isCompleted).length;
    final newLevel = (_completedCount ~/ tasksPerLevel) + 1;

    if (newLevel > _level) {
      // Level Up!
      _level = newLevel;
      _triggerLevelUpAnimation();
    } else {
      _level = newLevel;
    }
  }

  // Sends the new level to the Rive animation
  void _triggerLevelUpAnimation() {
    // 1. Update the 'Level' Number Input in the Rive state machine
    _levelInput?.value = _level.toDouble();
    
    // 2. Trigger a short 'Celebrate' animation for flair
    _celebrationTrigger?.value = true;

    // Show a simple level-up snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 LEVEL UP! You are now Level $_level! 🎉'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.amber.shade700,
      ),
    );
  }

  // Toggles task completion status and updates level
  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
      _updateMetrics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gamified To-Do List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Row(
        children: [
          // Left Panel: To-Do List
          Expanded(
            flex: 2,
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  elevation: task.isCompleted ? 1 : 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: task.isCompleted ? Colors.grey : Colors.black87,
                      ),
                    ),
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (val) => _toggleTaskCompletion(task),
                    ),
                    onTap: () => _toggleTaskCompletion(task),
                  ),
                );
              },
            ),
          ),

          // Right Panel: Rive Avatar & Stats
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.deepPurple.shade50,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- Stats Card ---
                  Card(
                    elevation: 8,
                    color: Colors.deepPurple.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Current Level:', style: TextStyle(fontSize: 16, color: Colors.deepPurple.shade800)),
                          Text(
                            '$_level',
                            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Completed Tasks: $_completedCount',
                            style: TextStyle(fontSize: 14, color: Colors.deepPurple.shade900),
                          ),
                          Text(
                            'Tasks to next level: ${tasksPerLevel - (_completedCount % tasksPerLevel)}',
                            style: TextStyle(fontSize: 14, color: Colors.deepPurple.shade900),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),

                  // --- Rive Animation Area ---
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          )
                        ]
                      ),
                      child: Center(
                        child: _levelInput == null
                            ? const Text('Loading Rive Asset...', style: TextStyle(fontStyle: FontStyle.italic))
                            : RiveAnimation.asset(
                                'assets/avatar.riv', // Path to your Rive file
                                fit: BoxFit.contain,
                                onInit: _onRiveInit,
                                stateMachineName: 'LevelController', // Must match the name in Rive
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
