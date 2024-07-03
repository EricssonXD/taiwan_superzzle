import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taiwan_superzzle/feature/settings/settings_provider.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_model.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_provider.dart';
import 'package:taiwan_superzzle/utils/router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flip_card/flip_card.dart';

@RoutePage()
class SuperzzleScreen extends StatelessWidget {
  const SuperzzleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("對對碰"),
        actions: [
          IconButton(
            onPressed: () => context.navigateTo(const HomeRoute()),
            icon: const Icon(
              Icons.pause,
            ),
          ),
        ],
      ),
      body: const SuperzzleGrid(),
    );
  }
}

class SuperzzleGrid extends ConsumerWidget {
  const SuperzzleGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final superzzleCards = ref.watch(superzzleGameStateProvider);
    int id = 0;

    return GridView.count(
      crossAxisCount: ref.watch(settingsStateProvider).cardsPerRow,
      children: superzzleCards.map((e) {
        return SuperzzleCard(card: e, id: id++);
      }).toList(),
    );
  }
}

class SuperzzleCard extends HookConsumerWidget {
  const SuperzzleCard({
    super.key,
    required this.card,
    required this.id,
  });

  static const double _flipDuration = 500;

  final SuperzzleCardModel card;
  final int id;

  void openCard(WidgetRef ref) {
    ref
        .read(superzzleGameStateProvider.notifier)
        .setCardState(id, SuperzzleCardState.opened);
  }

  void closeCard(WidgetRef ref) {
    ref
        .read(superzzleGameStateProvider.notifier)
        .setCardState(id, SuperzzleCardState.closed);
  }

  void toggleCard(WidgetRef ref) {
    if (card.state == SuperzzleCardState.opened) {
      closeCard(ref);
    } else {
      openCard(ref);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget front = Center(
      key: Key("${card.toString()}A"),
      child: Text(card.text + id.toString() + card.state.toString()),
    );

    const Widget back = Center(
      child: Text("Back"),
    );

    final isOpened = card.state == SuperzzleCardState.opened;

    Animate.restartOnHotReload = true;

    Widget flipTransition(Widget widget, Animation<double> animation) {
      final flipAnimation = Tween(begin: pi, end: 0.0).animate(animation);
      return AnimatedBuilder(
        animation: flipAnimation,
        builder: (context, child) {
          final isUnder = (ValueKey(isOpened) == widget.key);
          final value =
              isUnder ? min(flipAnimation.value, pi / 2) : flipAnimation.value;
          return Transform(
            transform: Matrix4.rotationY(value),
            alignment: Alignment.center,
            child: child,
          );
        },
        child: widget,
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
      child: GestureDetector(
        onTap: () => toggleCard(ref),
        child: AnimatedSwitcher(
          duration: _flipDuration.ms,
          reverseDuration: _flipDuration.ms,
          transitionBuilder: flipTransition,
          child: isOpened
              ? CardContent(
                  key: Key("${card.toString()}F"),
                  card: card,
                  id: id,
                  child: front,
                )
              : CardContent(
                  key: Key("${card.toString()}B"),
                  card: card,
                  id: id,
                  child: back,
                ),
        ),

        // child: CardContent(card: card, id: id, child: back)
        //     .animate(
        //       target: card.state == SuperzzleCardState.opened ? 0 : 1,
        //     )
        //     .flipH(
        //       duration: _flipDuration.ms,
        //     )
        //     .animate(
        //       target: card.state == SuperzzleCardState.opened ? 1 : 0,
        //     )
        //     .swap(
        //       duration: _flipDuration.ms,
        //       builder: (context, child) => GestureDetector(
        //         onTap: () => closeCard(ref),
        //         child: CardContent(
        //           card: card,
        //           id: id,
        //           child: front,
        //         ).animate().flipH(begin: 0.5, end: 0),
        //       ),
        //     ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent(
      {super.key, required this.card, required this.id, required this.child});

  final SuperzzleCardModel card;
  final int id;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: child,
    );
  }
}
