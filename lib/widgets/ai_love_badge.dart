import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';

enum _BurstMode { mixed, chatGpt, gemini, mega }

enum _ParticleKind { chatGpt, gemini, heart, spark }

class _FireworkParticle {
  _FireworkParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.rotation,
    required this.spin,
    required this.life,
    required this.maxLife,
    required this.kind,
    required this.color,
  });

  double x;
  double y;
  double vx;
  double vy;
  double size;
  double rotation;
  double spin;
  double life;
  final double maxLife;
  final _ParticleKind kind;
  final Color color;
  final List<Offset> trail = [];

  double get progress => (life / maxLife).clamp(0.0, 1.0);
  bool get isAlive => life < maxLife;
}

class AiLoveFloatingBadge extends StatefulWidget {
  const AiLoveFloatingBadge({super.key});

  @override
  State<AiLoveFloatingBadge> createState() => _AiLoveFloatingBadgeState();
}

class _AiLoveFloatingBadgeState extends State<AiLoveFloatingBadge>
    with TickerProviderStateMixin {
  final _buttonKey = GlobalKey();
  final _chatGptKey = GlobalKey();
  final _geminiKey = GlobalKey();
  final _rng = math.Random();
  final List<_FireworkParticle> _particles = [];
  final ValueNotifier<int> _fireworksRepaint = ValueNotifier<int>(0);

  late final AnimationController _floatController;
  late final AnimationController _pressController;
  late final Ticker _physicsTicker;

  OverlayEntry? _fireworkOverlay;
  Duration? _lastTick;

  bool _expanded = false;
  bool _motionPaused = false;
  int _tapCount = 0;
  Offset _magneticOffset = Offset.zero;
  double _magneticTilt = 0;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _physicsTicker = createTicker(_onPhysicsTick);
  }

  void _syncAmbientMotion() {
    if (_motionPaused || _expanded) {
      if (_floatController.isAnimating) {
        _floatController.stop();
      }
    } else if (!_floatController.isAnimating) {
      _floatController.repeat();
    }
  }

  @override
  void dispose() {
    _physicsTicker.dispose();
    _fireworkOverlay?.remove();
    _fireworkOverlay = null;
    _fireworksRepaint.dispose();
    _floatController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  void _onPhysicsTick(Duration elapsed) {
    final dt = _lastTick == null
        ? 0.016
        : ((elapsed - _lastTick!).inMicroseconds / 1000000.0).clamp(0.001, 0.05);
    _lastTick = elapsed;

    const gravity = 560.0;
    const drag = 0.988;

    for (final p in _particles) {
      p.life += dt;
      if (p.trail.length >= 6) {
        p.trail.removeAt(0);
      }
      p.trail.add(Offset(p.x, p.y));

      p.vx *= drag;
      p.vy = (p.vy * drag) + (gravity * dt);
      p.x += p.vx * dt;
      p.y += p.vy * dt;
      p.rotation += p.spin * dt;
    }

    _particles.removeWhere((p) => !p.isAlive);

    if (_particles.isEmpty) {
      _physicsTicker.stop();
      _lastTick = null;
      _fireworkOverlay?.remove();
      _fireworkOverlay = null;
    } else {
      _fireworksRepaint.value++;
    }
  }

  void _ensureOverlay() {
    if (_fireworkOverlay != null) return;
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    _fireworkOverlay = OverlayEntry(
      builder: (_) => Positioned.fill(
        child: IgnorePointer(
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _FireworksOverlayPainter(
                particles: _particles,
                repaint: _fireworksRepaint,
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(_fireworkOverlay!);
  }

  Offset? _originForKey(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return null;
    final topLeft = renderBox.localToGlobal(Offset.zero);
    return Offset(
      topLeft.dx + renderBox.size.width / 2,
      topLeft.dy + renderBox.size.height / 2,
    );
  }

  void _spawnBurst(_BurstMode mode, {GlobalKey? sourceKey}) {
    final origin = _originForKey(sourceKey ?? _buttonKey);
    if (origin == null) return;

    final palette = EditorialPalette.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final chatGptColor = isDark
        ? const Color(0xFF34D399)
        : const Color(0xFF0E7A5F);
    final geminiColor = isDark
        ? const Color(0xFF60A5FA)
        : const Color(0xFF2563EB);
    final accentColor = palette.accent;
    final inkColor = palette.ink;

    final count = switch (mode) {
      _BurstMode.mixed => 26,
      _BurstMode.chatGpt => 18,
      _BurstMode.gemini => 18,
      _BurstMode.mega => 40,
    };

    for (var i = 0; i < count; i++) {
      // Fan upward and left from the bottom-right corner so fireworks arc across view.
      final spread = mode == _BurstMode.mega ? 1.5 : 1.25;
      final baseAngle = -math.pi * 0.66;
      final angle = baseAngle + (_rng.nextDouble() - 0.5) * spread;
      final speed = (mode == _BurstMode.mega ? 520.0 : 420.0) +
          _rng.nextDouble() * 340.0;

      final _ParticleKind kind;
      final Color color;

      switch (mode) {
        case _BurstMode.chatGpt:
          kind = i % 4 == 0 ? _ParticleKind.spark : _ParticleKind.chatGpt;
          color = i % 3 == 0 ? inkColor : chatGptColor;
        case _BurstMode.gemini:
          kind = i % 4 == 0 ? _ParticleKind.spark : _ParticleKind.gemini;
          color = i % 2 == 0 ? geminiColor : accentColor;
        case _BurstMode.mixed:
        case _BurstMode.mega:
          final roll = i % 6;
          if (roll == 0 || roll == 3) {
            kind = _ParticleKind.chatGpt;
            color = roll == 0 ? chatGptColor : inkColor;
          } else if (roll == 1 || roll == 4) {
            kind = _ParticleKind.gemini;
            color = roll == 1 ? geminiColor : accentColor;
          } else if (roll == 2) {
            kind = _ParticleKind.heart;
            color = accentColor;
          } else {
            kind = _ParticleKind.spark;
            color = i.isEven ? accentColor : geminiColor;
          }
      }

      _particles.add(
        _FireworkParticle(
          x: origin.dx + (_rng.nextDouble() - 0.5) * 28,
          y: origin.dy + (_rng.nextDouble() - 0.5) * 12,
          vx: math.cos(angle) * speed,
          vy: math.sin(angle) * speed - 130,
          size: kind == _ParticleKind.spark
              ? 7 + _rng.nextDouble() * 5
              : 22 + _rng.nextDouble() * 13,
          rotation: _rng.nextDouble() * math.pi * 2,
          spin: (_rng.nextDouble() - 0.5) * 7.0,
          life: 0,
          maxLife: 1.35 + _rng.nextDouble() * 0.7,
          kind: kind,
          color: color,
        ),
      );
    }

    _ensureOverlay();
    if (!_physicsTicker.isActive) {
      _lastTick = null;
      _physicsTicker.start();
    }
    _fireworksRepaint.value++;
  }

  void _handleMainTap() {
    _pressController.forward(from: 0);
    setState(() {
      _tapCount += 1;
      _expanded = !_expanded;
      _magneticOffset = Offset.zero;
      _magneticTilt = 0;
    });
    _syncAmbientMotion();
    _spawnBurst(_tapCount >= 5 ? _BurstMode.mega : _BurstMode.mixed);
  }

  void _handleModelTap(_BurstMode mode, GlobalKey sourceKey) {
    setState(() => _tapCount += 1);
    _spawnBurst(mode, sourceKey: sourceKey);
  }

  void _togglePauseMotion() {
    setState(() => _motionPaused = !_motionPaused);
    _syncAmbientMotion();
  }

  void _close() {
    if (!_expanded) return;
    setState(() => _expanded = false);
    _syncAmbientMotion();
  }

  void _handleHover(PointerHoverEvent event) {
    if (_expanded || _motionPaused) return;
    final renderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;
    final center = Offset(
      renderBox.size.width / 2,
      renderBox.size.height / 2,
    );
    final delta = event.localPosition - center;
    final nx = (delta.dx / (renderBox.size.width / 2)).clamp(-1.0, 1.0);
    final ny = (delta.dy / (renderBox.size.height / 2)).clamp(-1.0, 1.0);

    setState(() {
      _magneticOffset = Offset(nx * 8.0, ny * 6.0);
      _magneticTilt = nx * 0.045;
    });
  }

  void _resetHover() {
    if (_magneticOffset == Offset.zero && _magneticTilt == 0) return;
    setState(() {
      _magneticOffset = Offset.zero;
      _magneticTilt = 0;
    });
  }

  String get _comboMessage {
    if (_tapCount >= 10) {
      return 'Combo x$_tapCount. Achievement unlocked: Certified AI Enthusiast.';
    }
    if (_tapCount >= 6) {
      return 'Combo x$_tapCount. You officially found the fun corner of this portfolio.';
    }
    if (_tapCount >= 3) {
      return 'Combo x$_tapCount. Human direction, AI velocity, 60fps Flutter physics.';
    }
    return 'Tap ChatGPT or Gemini above to fire a dedicated burst.';
  }

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.escape): _close,
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.08),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: _expanded
                ? Padding(
                    key: const ValueKey('ai-love-popover'),
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: palette.surfaceCrisp,
                      elevation: 10,
                      shadowColor: Colors.black.withValues(alpha: 0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: palette.borderStrong),
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 12, 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'AI Colophon',
                                      style: TextStyle(
                                        fontFamily: AppTheme.displayFont,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: palette.ink,
                                      ),
                                    ),
                                  ),
                                  if (_tapCount > 1)
                                    Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: palette.accent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'x$_tapCount',
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w700,
                                          color: palette.onAccent,
                                          fontFeatures: const [
                                            FontFeature.tabularFigures(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  IconButton(
                                    onPressed: _close,
                                    icon: const Icon(Icons.close, size: 17),
                                    tooltip: 'Close AI credits',
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: _InteractiveModelTile(
                                      key: _chatGptKey,
                                      label: 'ChatGPT',
                                      hint: 'Tap to burst',
                                      icon: _ChatGptMark(
                                        color: palette.ink,
                                        size: 28,
                                      ),
                                      onTap: () => _handleModelTap(
                                        _BurstMode.chatGpt,
                                        _chatGptKey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _InteractiveModelTile(
                                      key: _geminiKey,
                                      label: 'Gemini',
                                      hint: 'Tap to burst',
                                      icon: _GeminiMark(
                                        color: palette.accent,
                                        size: 28,
                                      ),
                                      onTap: () => _handleModelTap(
                                        _BurstMode.gemini,
                                        _geminiKey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _comboMessage,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: palette.inkMuted,
                                  height: 1.45,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        setState(() => _tapCount += 1);
                                        _spawnBurst(_BurstMode.mega);
                                      },
                                      icon: const Icon(
                                        Icons.celebration_outlined,
                                        size: 16,
                                      ),
                                      label: const Text('Fireworks'),
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: const Size(44, 40),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        textStyle: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  OutlinedButton(
                                    onPressed: _togglePauseMotion,
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size(44, 40),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    child: Text(
                                      _motionPaused ? 'Float on' : 'Pause',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey('ai-love-closed')),
          ),
          MouseRegion(
            onHover: _handleHover,
            onExit: (_) => _resetHover(),
            child: AnimatedBuilder(
              animation: Listenable.merge([_floatController, _pressController]),
              builder: (context, child) {
                final t = _floatController.value;
                final activeFloat = !_motionPaused && !_expanded;
                final bobX = activeFloat ? math.sin(t * 2 * math.pi) * 5.0 : 0.0;
                final bobY = activeFloat ? math.sin(t * 4 * math.pi) * 7.0 : 0.0;
                final bobTilt =
                    activeFloat ? math.sin(t * 2 * math.pi) * 0.028 : 0.0;

                final press = _pressController.value;
                final pressScale = press == 0 || press == 1
                    ? 1.0
                    : 1.0 - math.sin(press * math.pi) * 0.09 +
                        math.sin(press * math.pi * 2) * 0.05;

                return Transform.translate(
                  offset: Offset(
                    bobX + _magneticOffset.dx,
                    bobY + _magneticOffset.dy,
                  ),
                  child: Transform.rotate(
                    angle: bobTilt + _magneticTilt,
                    child: Transform.scale(scale: pressScale, child: child),
                  ),
                );
              },
              child: Semantics(
                button: true,
                toggled: _expanded,
                label: "Made With AI's Love! Launch ChatGPT and Gemini fireworks",
                child: Material(
                  key: _buttonKey,
                  color: palette.surfaceCrisp,
                  elevation: 6,
                  shadowColor: Colors.black.withValues(alpha: 0.18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: _expanded ? palette.accent : palette.borderStrong,
                      width: _expanded ? 1.5 : 1,
                    ),
                  ),
                  child: InkWell(
                    onTap: _handleMainTap,
                    borderRadius: BorderRadius.circular(8),
                    hoverColor: palette.accent.withValues(alpha: 0.08),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 44),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.favorite_rounded,
                              size: 16,
                              color: palette.accent,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Made With AI's Love!",
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: palette.ink,
                              ),
                            ),
                            if (_tapCount > 1 && !_expanded) ...[
                              const SizedBox(width: 6),
                              Text(
                                'x$_tapCount',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: palette.accent,
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InteractiveModelTile extends StatelessWidget {
  const _InteractiveModelTile({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String hint;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    return Material(
      color: palette.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: palette.hairline),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: palette.accent.withValues(alpha: 0.08),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: palette.ink,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                hint,
                style: TextStyle(
                  fontSize: 11,
                  color: palette.inkMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FireworksOverlayPainter extends CustomPainter {
  _FireworksOverlayPainter({
    required this.particles,
    required super.repaint,
  });

  final List<_FireworkParticle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = p.progress;
      final opacity = t < 0.1
          ? (t / 0.1)
          : (1.0 - ((t - 0.1) / 0.9)).clamp(0.0, 1.0);
      final scale = t < 0.14 ? 0.45 + (t / 0.14) * 0.65 : 1.1 - (t * 0.28);

      for (var i = 0; i < p.trail.length; i++) {
        final trailAlpha = opacity * ((i + 1) / (p.trail.length + 1)) * 0.34;
        final trailPaint = Paint()
          ..color = p.color.withValues(alpha: trailAlpha)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(
          p.trail[i],
          (p.size * 0.15) * ((i + 1) / p.trail.length),
          trailPaint,
        );
      }

      canvas.save();
      canvas.translate(p.x, p.y);
      canvas.rotate(p.rotation);
      canvas.scale(scale);

      final drawColor = p.color.withValues(alpha: opacity);
      final half = p.size / 2;

      switch (p.kind) {
        case _ParticleKind.chatGpt:
          _drawChatGpt(canvas, p.size, drawColor);
        case _ParticleKind.gemini:
          _drawGemini(canvas, p.size, drawColor);
        case _ParticleKind.heart:
          _drawHeart(canvas, p.size, drawColor);
        case _ParticleKind.spark:
          canvas.drawCircle(
            Offset.zero,
            half * 0.65,
            Paint()..color = drawColor,
          );
      }
      canvas.restore();
    }
  }

  void _drawChatGpt(Canvas canvas, double size, Color color) {
    final radius = size * 0.44;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size * 0.088
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 6; i++) {
      canvas.save();
      canvas.rotate((i * math.pi / 3) - math.pi / 2);
      final rect = Rect.fromCenter(
        center: Offset(0, -radius * 0.42),
        width: radius * 0.84,
        height: radius * 1.04,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(radius * 0.42)),
        stroke,
      );
      canvas.restore();
    }
  }

  void _drawGemini(Canvas canvas, double size, Color color) {
    final half = size / 2;
    final path = Path()
      ..moveTo(0, -half)
      ..quadraticBezierTo(0, 0, half, 0)
      ..quadraticBezierTo(0, 0, 0, half)
      ..quadraticBezierTo(0, 0, -half, 0)
      ..quadraticBezierTo(0, 0, 0, -half)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  void _drawHeart(Canvas canvas, double size, Color color) {
    final s = size * 0.5;
    final path = Path()
      ..moveTo(0, s * 0.72)
      ..cubicTo(-s * 1.25, -s * 0.05, -s * 0.85, -s * 1.05, 0, -s * 0.35)
      ..cubicTo(s * 0.85, -s * 1.05, s * 1.25, -s * 0.05, 0, s * 0.72)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_FireworksOverlayPainter oldDelegate) => false;
}

class _ChatGptMark extends StatelessWidget {
  const _ChatGptMark({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _ChatGptPainter(color),
    );
  }
}

class _ChatGptPainter extends CustomPainter {
  const _ChatGptPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.44;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.078
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (var i = 0; i < 6; i++) {
      final angle = (i * math.pi / 3) - math.pi / 2;
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);
      final rect = Rect.fromCenter(
        center: Offset(0, -radius * 0.42),
        width: radius * 0.86,
        height: radius * 1.06,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(radius * 0.43)),
        stroke,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ChatGptPainter oldDelegate) => oldDelegate.color != color;
}

class _GeminiMark extends StatelessWidget {
  const _GeminiMark({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _GeminiPainter(color),
    );
  }
}

class _GeminiPainter extends CustomPainter {
  const _GeminiPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;

    final path = Path()
      ..moveTo(cx, 0)
      ..quadraticBezierTo(cx, cy, w, cy)
      ..quadraticBezierTo(cx, cy, cx, h)
      ..quadraticBezierTo(cx, cy, 0, cy)
      ..quadraticBezierTo(cx, cy, cx, 0)
      ..close();

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_GeminiPainter oldDelegate) => oldDelegate.color != color;
}
