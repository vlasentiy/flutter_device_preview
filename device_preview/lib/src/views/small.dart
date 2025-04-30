import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tool_panel/tool_panel.dart';

/// The tool layout when the screen is small.
class DevicePreviewSmallLayout extends StatelessWidget {
  /// Create a new panel from the given tools grouped as [slivers].
  const DevicePreviewSmallLayout({
    super.key,
    required this.maxMenuHeight,
    required this.scaffoldKey,
    required this.onMenuVisibleChanged,
    required this.slivers,
    required this.safeAreaBottomPadding,
  });

  /// The maximum modal menu height.
  final double maxMenuHeight;

  /// The key of the [Scaffold] that must be used to show the modal menu.
  final GlobalKey<ScaffoldState> scaffoldKey;

  /// Invoked each time the menu is shown or hidden.
  final ValueChanged<bool> onMenuVisibleChanged;

  /// The sections containing the tools.
  ///
  /// They must be [Sliver]s.
  final List<Widget> slivers;

  final double safeAreaBottomPadding;

  @override
  Widget build(BuildContext context) {
    final toolbarTheme = context.select(
      (DevicePreviewStore store) => store.settings.toolbarTheme,
    );
    return Theme(
      data: toolbarTheme.asThemeData(),
      child: SafeArea(
        top: false,
        child: _BottomToolbar(
          showPanel: () async {
            onMenuVisibleChanged(true);
            final sheet = scaffoldKey.currentState?.showBottomSheet(
              (context) => ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: ToolPanel(
                  safeAreaBottomPadding: safeAreaBottomPadding,
                  isModal: true,
                  slivers: slivers,
                ),
              ),
              constraints: BoxConstraints(
                maxHeight: maxMenuHeight,
              ),
              backgroundColor: Colors.transparent,
            );
            await sheet?.closed;
            onMenuVisibleChanged(false);
          },
        ),
      ),
    );
  }
}

class _BottomToolbar extends StatefulWidget {
  const _BottomToolbar({
    required this.showPanel,
  });

  final VoidCallback showPanel;

  @override
  State<_BottomToolbar> createState() => _BottomToolbarState();
}

class _BottomToolbarState extends State<_BottomToolbar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1 / 6,
    )
        .chain(
          CurveTween(
            curve: _ClockTickCurve(),
          ),
        )
        .animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.forward(from: 0.0);
      }
    });

    final isEnabled = context.read<DevicePreviewStore>().data.isEnabled;
    if (isEnabled) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = context.select(
      (DevicePreviewStore store) => store.data.isEnabled,
    );

    if (isEnabled) {
      if (!_controller.isAnimating) {
        _controller.forward();
      }
    } else {
      _controller.stop();
    }

    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.grey.withValues(alpha: 0.2),
        highlightColor: Colors.grey.withValues(alpha: 0.2),
      ),
      child: Material(
        child: ListTile(
          title: const Text(
            'Settings',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: isEnabled ? widget.showPanel : null,
          leading: RotationTransition(
            turns: _animation,
            child: const Icon(Icons.settings, size: 30),
          ),
          trailing: Switch(
            value: isEnabled,
            onChanged: (v) {
              final state = context.read<DevicePreviewStore>();
              state.data = state.data.copyWith(isEnabled: v);
              final devicePreview =
                  context.findAncestorWidgetOfExactType<DevicePreview>();
              devicePreview?.onEnabledToggle?.call(v, state);
            },
          ),
        ),
      ),
    );
  }
}

class _ClockTickCurve extends Curve {
  @override
  double transform(double t) {
    if (t < 0.5) {
      return t * 2;
    } else {
      return 1.0;
    }
  }
}
