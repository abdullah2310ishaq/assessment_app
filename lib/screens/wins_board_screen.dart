import 'package:flutter/material.dart';
import '../models/win_model.dart';
import '../widgets/app_gradient_background.dart';
import '../widgets/app_header.dart';
import '../widgets/section_header.dart';
import '../widgets/win_card.dart';
import '../widgets/add_win_dialog.dart';

class WinsBoardScreen extends StatefulWidget {
  const WinsBoardScreen({Key? key}) : super(key: key);

  @override
  State<WinsBoardScreen> createState() => _WinsBoardScreenState();
}

class _WinsBoardScreenState extends State<WinsBoardScreen> {
  List<Win> wins = [
    Win(
      id: '1',
      founderName: 'Abdullah Khan',
      company: 'TechFlow',
      content: 'Just closed our seed round! \$2M to revolutionize workflow automation 🚀',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      reactions: {'🔥': 12, '🎉': 8, '💪': 5},
      avatar: '👨‍💼',
    ),
    Win(
      id: '2',
      founderName: 'Ishaq Ali',
      company: 'GreenTech Solutions',
      content: 'Hit 10K users this month! The sustainability movement is real 🌱',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      reactions: {'🌟': 15, '🎊': 7, '💚': 9},
      avatar: '👨‍💻',
    ),
    Win(
      id: '3',
      founderName: 'Salman Ahmad',
      company: 'HealthFirst AI',
      content: 'Featured in TechCrunch today! Our AI diagnostic tool is getting recognition 🏆',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      reactions: {'🚀': 20, '🎯': 6, '👏': 11},
      avatar: '👨‍⚕️',
    ),
    Win(
      id: '4',
      founderName: 'Aizaz Sheikh',
      company: 'FinTech Pro',
      content: 'Just launched our MVP! First 100 users onboarded and loving it 🎯',
      timestamp: DateTime.now().subtract(const Duration(hours: 12)),
      reactions: {'🎉': 18, '🎯': 8, '🚀': 12},
      avatar: '💼',
    ),
    Win(
      id: '5',
      founderName: 'Zain Hassan',
      company: 'EduTech Solutions',
      content: 'Partnership deal signed with major university! Scaling education tech 🎓',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      reactions: {'🎓': 22, '🔥': 9, '👏': 14},
      avatar: '📚',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppHeader(
                title: 'AOM Founder Family',
                subtitle: 'Celebrate wins together 🥝',
                totalCount: wins.length,
                countLabel: 'wins',
              ),
              Expanded(
                child: _buildMainContent(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const SectionHeader(
            icon: Icons.celebration,
            title: 'Recent Wins',
            subtitle: 'Tap 🔥 to celebrate!',
          ),
          Expanded(
            child: _buildWinsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWinsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: wins.length,
      itemBuilder: (context, index) {
        final win = wins[index];
        return WinCard(
          win: win,
          onReactionTap: (emoji) => _addReaction(win.id, emoji),
          onReaction: () => _addReaction(win.id, '🔥'),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _showAddWinDialog,
      backgroundColor: const Color(0xFF667eea),
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'Share Win',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _addReaction(String winId, String emoji) {
    setState(() {
      final winIndex = wins.indexWhere((w) => w.id == winId);
      if (winIndex != -1) {
        final currentCount = wins[winIndex].reactions[emoji] ?? 0;
        wins[winIndex].reactions[emoji] = currentCount + 1;
      }
    });
    
    _showReactionFeedback(emoji);
  }

  void _showReactionFeedback(String emoji) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $emoji reaction!'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF667eea),
      ),
    );
  }

  void _showAddWinDialog() {
    showDialog(
      context: context,
      builder: (context) => AddWinDialog(
        onWinAdded: _addWin,
      ),
    );
  }

  void _addWin(Win newWin) {
    setState(() {
      wins.insert(0, newWin);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Win shared! The community will celebrate with you 🎉'),
        backgroundColor: Color(0xFF667eea),
      ),
    );
  }
}