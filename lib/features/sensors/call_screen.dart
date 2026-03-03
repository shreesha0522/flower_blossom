import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _isNear = false;
  bool _isMuted = false;
  bool _isSpeaker = false;
  int _seconds = 0;
  StreamSubscription<int>? _proximitySubscription;
  Timer? _callTimer;

  @override
  void initState() {
    super.initState();
    _startProximitySensor();
    _startCallTimer();
  }

  void _startProximitySensor() async {
    try {
      await ProximitySensor.setProximityScreenOff(true);
      _proximitySubscription = ProximitySensor.events.listen(
        (int event) {
          if (mounted) {
            setState(() {
              _isNear = (event > 0);
            });
          }
        },
        onError: (e) => debugPrint('Proximity sensor error: $e'),
      );
    } catch (e) {
      debugPrint('Proximity sensor not available: $e');
    }
  }

  void _startCallTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  String get _callDuration {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _endCall() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _proximitySubscription?.cancel();
    ProximitySensor.setProximityScreenOff(false);
    _callTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // When near (held to ear) → black screen like a real phone call
    if (_isNear) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox.expand(),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Shop icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 229, 128, 162),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.local_florist, size: 56, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Shop name
            const Text(
              'Flower Blossom',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '+977-1-234567',
              style: TextStyle(color: Colors.white60, fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Call timer
            Text(
              _callDuration,
              style: const TextStyle(color: Colors.white38, fontSize: 14),
            ),

            const Spacer(),

            const SizedBox(height: 32),

            // Mute & Speaker buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CallButton(
                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                  label: _isMuted ? 'Unmute' : 'Mute',
                  onTap: () => setState(() => _isMuted = !_isMuted),
                ),
                _CallButton(
                  icon: _isSpeaker ? Icons.volume_up : Icons.volume_down,
                  label: 'Speaker',
                  isActive: _isSpeaker,
                  onTap: () => setState(() => _isSpeaker = !_isSpeaker),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // End call button
            GestureDetector(
              onTap: _endCall,
              child: Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.call_end, color: Colors.white, size: 32),
              ),
            ),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _CallButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _CallButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color.fromARGB(255, 229, 128, 162)
                  : Colors.white24,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
        ],
      ),
    );
  }
}