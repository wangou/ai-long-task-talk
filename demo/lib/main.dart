import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Figma Home Demo',
      scrollBehavior: const _DemoScrollBehavior(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffff3aa5)),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      builder: (context, child) {
        return MediaQuery.withNoTextScaling(child: child ?? const SizedBox());
      },
      home: const Scaffold(
        backgroundColor: Color(0xfff4f4f5),
        body: Center(child: PhoneCanvas()),
      ),
    );
  }
}

class _DemoScrollBehavior extends MaterialScrollBehavior {
  const _DemoScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}

class PhoneCanvas extends StatelessWidget {
  const PhoneCanvas({super.key});

  static const String _assetRoot = 'assets/figma';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const ValueKey('phone-canvas'),
      width: 390,
      height: 844,
      child: ClipRect(
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: const [
            Positioned.fill(child: _CanvasBackground()),
            _StatusBar(),
            Positioned(
              left: 12,
              top: 61,
              width: 366,
              child: _PostCard(
                key: ValueKey('first-post-card'),
                showBody: true,
                imageAssets: [
                  '$_assetRoot/post-photo-1.jpg',
                  '$_assetRoot/post-photo-2.jpg',
                  '$_assetRoot/post-photo-1.jpg',
                ],
              ),
            ),
            Positioned(
              left: 12,
              top: 428,
              width: 366,
              child: _PostCard(
                key: ValueKey('second-post-card'),
                showBody: false,
                imageAssets: [
                  '$_assetRoot/post-photo-1.jpg',
                  '$_assetRoot/post-photo-2.jpg',
                  '$_assetRoot/post-photo-1.jpg',
                ],
              ),
            ),
            _BottomNavigation(),
            _FloatingAddButton(),
          ],
        ),
      ),
    );
  }
}

class _CanvasBackground extends StatelessWidget {
  const _CanvasBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xfffdf2f8), Color(0xfffaf5ff)],
        ),
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  static const String _assetRoot = 'assets/figma';

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: const ValueKey('status-bar'),
      left: 0,
      top: 0,
      width: 390,
      height: 47,
      child: Stack(
        children: [
          Positioned(
            left: 27,
            top: 15,
            width: 54,
            height: 20,
            child: Text(
              '9:41',
              textAlign: TextAlign.center,
              style: _TextStyles.statusTime,
            ),
          ),
          Positioned(
            left: 109,
            top: 0,
            width: 172,
            height: 32,
            child: SvgPicture.asset('$_assetRoot/status-notch.svg'),
          ),
          Positioned(
            left: 286,
            top: 20,
            width: 18,
            height: 12,
            child: SvgPicture.asset('$_assetRoot/mobile-signal.svg'),
          ),
          Positioned(
            left: 313,
            top: 20,
            width: 17,
            height: 11.83,
            child: SvgPicture.asset('$_assetRoot/wifi.svg'),
          ),
          const Positioned(
            left: 337,
            top: 19,
            width: 27.4,
            height: 13,
            child: _BatteryIndicator(),
          ),
        ],
      ),
    );
  }
}

class _BatteryIndicator extends StatelessWidget {
  const _BatteryIndicator();

  static const String _assetRoot = 'assets/figma';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          width: 25,
          height: 13,
          child: SvgPicture.asset('$_assetRoot/battery-outline.svg'),
        ),
        Positioned(
          left: 26,
          top: 4.39,
          width: 1.4,
          height: 4.22,
          child: SvgPicture.asset('$_assetRoot/battery-end.svg'),
        ),
        Positioned(
          left: 2,
          top: 2,
          width: 15,
          height: 9,
          child: SvgPicture.asset('$_assetRoot/battery-fill.svg'),
        ),
      ],
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    super.key,
    required this.showBody,
    required this.imageAssets,
  });

  final bool showBody;
  final List<String> imageAssets;

  static const String _bodyText =
      'Watched the sunset with him today, so beautiful and romantic 💕 Hope every day can be this sweet!';

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _CardHeader(),
            if (showBody) ...[
              const SizedBox(height: 10),
              const SizedBox(
                width: 334,
                height: 19,
                child: Text(
                  _bodyText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _TextStyles.body,
                ),
              ),
            ],
            const SizedBox(height: 10),
            _PhotoStrip(imageAssets: imageAssets),
            const SizedBox(height: 10),
            const _ActionBar(),
          ],
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 334,
      height: 44,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                  child: Text(
                    'Jane',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _TextStyles.name,
                  ),
                ),
                SizedBox(height: 2),
                SizedBox(
                  height: 15,
                  child: Text(
                    'Today - 10:30 AM - Corner window light',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _TextStyles.meta,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  static const String _assetRoot = 'assets/figma';

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        '$_assetRoot/avatar-emma.jpg',
        width: 44,
        height: 44,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _PhotoStrip extends StatelessWidget {
  const _PhotoStrip({required this.imageAssets});

  final List<String> imageAssets;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 334,
      height: 210,
      child: OverflowBox(
        alignment: Alignment.centerLeft,
        minWidth: 350,
        maxWidth: 350,
        minHeight: 210,
        maxHeight: 210,
        child: SizedBox(
          width: 350,
          height: 210,
          child: SingleChildScrollView(
            key: const ValueKey('photo-strip-scroll'),
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: Row(
              children: [
                for (var index = 0; index < imageAssets.length; index++) ...[
                  _PostPhoto(assetPath: imageAssets[index]),
                  if (index != imageAssets.length - 1)
                    const SizedBox(width: 12),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostPhoto extends StatelessWidget {
  const _PostPhoto({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 158,
      height: 210,
      foregroundDecoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(assetPath, fit: BoxFit.cover),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar();

  static const String _assetRoot = 'assets/figma';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 334,
      height: 20,
      child: Row(
        children: [
          _ActionItem(
            icon: SvgPicture.asset('$_assetRoot/like-active.svg'),
            label: '1',
            labelOpacity: 0.8,
          ),
          const SizedBox(width: 22),
          _ActionItem(
            icon: SvgPicture.asset('$_assetRoot/comment.svg'),
            label: 'Comment',
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.icon,
    required this.label,
    this.labelOpacity = 1,
  });

  final Widget icon;
  final String label;
  final double labelOpacity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 20, height: 20, child: icon),
        const SizedBox(width: 8),
        Opacity(
          opacity: labelOpacity,
          child: Text(label, style: _TextStyles.action),
        ),
      ],
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  static const String _assetRoot = 'assets/figma';

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: const ValueKey('bottom-navigation'),
      left: 0,
      bottom: 0,
      width: 390,
      height: 80,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xffe5e5e5), width: 0.8)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(
                icon: SvgPicture.asset('$_assetRoot/nav-home.svg'),
                label: 'HOME',
                active: true,
              ),
              _NavItem(
                icon: SvgPicture.asset('$_assetRoot/nav-camera.svg'),
                label: 'CAMERA',
              ),
              _NavItem(
                icon: SvgPicture.asset('$_assetRoot/nav-chat.svg'),
                label: 'CHAT',
              ),
              const _NavItem(icon: _ProfileIcon(), label: 'PROFILE'),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  final Widget icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xffff3aa5) : const Color(0xffadadad);

    return SizedBox(
      width: 58,
      height: 54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          SizedBox(width: 26, height: 26, child: icon),
          const SizedBox(height: 4),
          SizedBox(
            width: 58,
            height: 15,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: _TextStyles.navLabel.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon();

  static const String _assetRoot = 'assets/figma';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 4.5,
          top: 14,
          width: 17.01,
          height: 8.35,
          child: SvgPicture.asset('$_assetRoot/nav-profile-body.svg'),
        ),
        Positioned(
          left: 7.74,
          top: 2.74,
          width: 10.52,
          height: 10.52,
          child: SvgPicture.asset('$_assetRoot/nav-profile-head.svg'),
        ),
      ],
    );
  }
}

class _FloatingAddButton extends StatelessWidget {
  const _FloatingAddButton();

  static const String _assetRoot = 'assets/figma';

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: const ValueKey('floating-action-button'),
      left: 318,
      top: 660,
      width: 56,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset('$_assetRoot/fab-bg.svg', width: 56, height: 56),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
            ),
            child: const SizedBox(width: 20, height: 4),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
            ),
            child: const SizedBox(width: 4, height: 20),
          ),
        ],
      ),
    );
  }
}

abstract final class _TextStyles {
  static const Color ink = Color(0xff2d1b3d);

  static const TextStyle statusTime = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 20 / 16,
    letterSpacing: 0,
  );

  static const TextStyle name = TextStyle(
    color: ink,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 25 / 20,
    letterSpacing: 0,
  );

  static const TextStyle meta = TextStyle(
    color: Color.fromRGBO(45, 27, 61, 0.6),
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 15 / 12,
    letterSpacing: 0,
  );

  static const TextStyle body = TextStyle(
    color: ink,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 19 / 15,
    letterSpacing: 0,
  );

  static const TextStyle action = TextStyle(
    color: Color(0xff696969),
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0,
  );

  static const TextStyle navLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 13 / 11,
    letterSpacing: 0,
  );
}
