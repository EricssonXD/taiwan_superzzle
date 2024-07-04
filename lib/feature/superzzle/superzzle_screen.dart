import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taiwan_superzzle/feature/settings/settings_provider.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_model.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_provider.dart';
import 'package:taiwan_superzzle/utils/router.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
    ref.read(superzzleGameStateProvider.notifier).openCard(id);
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
      child: Text(
        card.text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: ref.watch(settingsStateProvider).fontSize,
        ),
      ),
    );

    const Widget back = Padding(
      padding: EdgeInsets.all(22.0),
      child: SizedBox.expand(
        child: FittedBox(
          child: Icon(
            Icons.church,
          ),
        ),
      ),
    );

    final isOpened = card.state != SuperzzleCardState.closed;

    Animate.restartOnHotReload = true;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
      child: GestureDetector(
        onTap: () => openCard(ref),
        child: CardContent(
          card: card,
          id: id,
          child: back,
        )
            .animate(
              autoPlay: false,
              target: isOpened ? 1 : 0,
            )
            .flipH(
              duration: _flipDuration.ms,
              begin: 0,
              end: 0.5,
            )
            .swap(
              duration: _flipDuration.ms,
              builder: (context, child) => CardContent(
                key: Key("${card.toString()}D"),
                card: card,
                id: id,
                child: front,
              ).animate().flipH(begin: -0.5, end: 0),
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
