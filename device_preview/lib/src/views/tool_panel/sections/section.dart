import 'package:flutter/material.dart';

/// A [Sliver] representing a section in the [DevicePreview] menu.
///
/// It is only composed of a section [title] header and a list of [children].
class ToolPanelSection extends StatelessWidget {
  /// Create a new panel section with the given [title] and [children].
  const ToolPanelSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  /// The section header content.
  final String title;

  /// The section children widgets.
  final List<Widget> children;

  final bool addLabel = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          if (addLabel)
            SafeArea(
              top: false,
              bottom: false,
              minimum: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text(
                title.toUpperCase(),
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ),
          ...children,
        ],
      ),
    );
  }
}
