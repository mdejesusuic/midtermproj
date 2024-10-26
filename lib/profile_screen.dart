import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String initialBio =
      "A passionate software engineer with experience in developing mobile applications and a strong interest in UI/UX design.";
  final List<String> initialGoals = [
    "Run a 10K race by the end of the year.",
    "Complete 100 workout sessions in 2024.",
    "Drink at least 2 liters of water daily."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                "Marc De Jesus",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Divider(height: 30, thickness: 2),

              // Bio Section
              _buildSectionTitle("Bio"),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  _showEditDialog(context, "Edit Bio", initialBio, (newBio) {
                    // Update the bio in the UI or state management solution
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.grey.shade300), // Optional: Add a border
                  ),
                  child: Text(
                    initialBio,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // User Goals Section
              _buildSectionTitle("Fitness Goals"),
              SizedBox(height: 10),
              GoalsSection(initialGoals: initialGoals),
              SizedBox(height: 20),

              // Achievements Section
              _buildSectionTitle("Achievements"),
              SizedBox(height: 10),
              AchievementsCard(
                title: "5K Run Completed",
                date: "March 10, 2024",
                badge: "🏅", // Example badge icon
              ),
              AchievementsCard(
                title: "10 Days of Consistent Workouts",
                date: "April 5, 2024",
                badge: "🎖️", // Example badge icon
              ),
              AchievementsCard(
                title: "Healthy Eating Badge",
                date: "April 15, 2024",
                badge: "🥗", // Example badge icon
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  void _showEditDialog(BuildContext context, String title, String initialText,
      Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: initialText);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter your text here"),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}

class GoalsSection extends StatelessWidget {
  final List<String> initialGoals;

  GoalsSection({required this.initialGoals});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: initialGoals.map((goal) {
        return GestureDetector(
          onTap: () {
            _showEditGoalDialog(context, goal, (newGoal) {
              // Update the goal in the UI or state management solution
            });
          },
          child: GoalCard(goal: goal),
        );
      }).toList(),
    );
  }

  void _showEditGoalDialog(
      BuildContext context, String initialGoal, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: initialGoal);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Goal"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter your goal here"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}

class GoalCard extends StatelessWidget {
  final String goal;

  GoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          goal,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class AchievementsCard extends StatelessWidget {
  final String title;
  final String date;
  final String badge;

  AchievementsCard({
    required this.title,
    required this.date,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(date, style: TextStyle(color: Colors.grey)),
              ],
            ),
            Text(badge, style: TextStyle(fontSize: 30)), // Display badge
          ],
        ),
      ),
    );
  }
}
