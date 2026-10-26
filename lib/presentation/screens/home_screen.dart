import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../business/cubit/home_cubit.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Start loading data when the screen is initialized
    context.read<HomeCubit>().loadInitialData();
  }

  // --- UI Building Blocks ---

  Widget _buildTopButtons(BuildContext context, HomeCubit cubit) {
    return Row(
      children: [
        // New Project Button (Filled Yellow)
        Expanded(
          child: ElevatedButton(
            onPressed: () => cubit.newProject(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF9C300),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
            child: const Text(
              'New Project',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Continue Project Button (Outlined Dark)
        Expanded(
          child: OutlinedButton(
            onPressed: () => cubit.continueProject(),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF2E323F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: Color(0xFFF9C300), width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
            child: const Text(
              'Continue Project',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCards(BuildContext context, HomeCubit cubit) {
    return Column(
      children: [
        // Conte Project Card
        FeatureCard(
          title: 'Conte Project',
          icon: Icons.folder_open,
          trailIcon: FontAwesomeIcons.drawPolygon,
          onTap: () {
            // Placeholder action
            cubit.showStatusUpdate('Opening Conte Project...', isSuccess: true);
          },
        ),
        const SizedBox(height: 16),

        // COGO Tools and Quick Area Calc (Two-column layout)
        Row(
          children: [
            Expanded(
              child: FeatureCard(
                title: 'COGO Tools',
                icon: FontAwesomeIcons.rulerCombined,
                onTap: () {
                  // Placeholder action
                  cubit.checkGps();
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FeatureCard(
                title: 'Quick Area Calc',
                icon: FontAwesomeIcons.calculator,
                onTap: () {
                  // Placeholder action
                  cubit.showStatusUpdate(
                    'Ready for Quick Area Calculation',
                    isSuccess: true,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Scaffold(
      extendBodyBehindAppBar: true, // Allows content to go behind app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Surveyor Calc Pro',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Icon(FontAwesomeIcons.compass, color: Color(0xFFF9C300)),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2E323F), // Dark background for the bar
        type: BottomNavigationBarType
            .fixed, // Essential for fixed number of items
        selectedItemColor: const Color(0xFFF9C300),
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Points',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Tools'),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file),
            label: 'Export',
          ),
        ],
      ),

      body: Stack(
        children: [
          // Background Image/Map Mock (Using a simple dark container for mock purposes)
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1E212B),
              image: DecorationImage(
                image: NetworkImage(
                  'https://placehold.co/600x1200/2A303F/A6A7AA/png?text=Topographic+Map',
                ),
                fit: BoxFit.cover,
                opacity: 0.2,
              ),
            ),
          ),

          // Main Content Area
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20), // Spacer below AppBar
                  _buildTopButtons(context, cubit),
                  const SizedBox(height: 32),
                  _buildFeatureCards(context, cubit),
                  const SizedBox(
                    height: 400,
                  ), // Space to push content up and test scrolling
                ],
              ),
            ),
          ),

          // Status Overlay (Listens to HomeCubit state changes)
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              // If the state is a status update, schedule a reset after 3 seconds
              if (state is HomeStatusUpdate) {
                Future.delayed(const Duration(seconds: 3), () {
                  // After showing the message, reset to HomeLoaded
                  context.read<HomeCubit>().loadInitialData();
                });
              }
            },
            builder: (context, state) {
              if (state is HomeStatusUpdate) {
                return Positioned(
                  bottom: 100, // Position above the BottomNavigationBar
                  left: 0,
                  right: 0,
                  child: Center(
                    child: StatusOverlay(
                      message: state.message,
                      isSuccess: state.isSuccess,
                    ),
                  ),
                );
              }
              // Return an empty container when no status is active
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
