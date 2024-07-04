import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taiwan_superzzle/feature/settings/settings_provider.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_card_model.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_provider.dart';
import 'package:taiwan_superzzle/utils/router.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:auto_size_text/auto_size_text.dart';

@RoutePage()
class SuperzzleScreen extends ConsumerWidget {
  const SuperzzleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(superzzleGameStateProvider.notifier).restart(),
            icon: const Icon(
              Icons.restart_alt,
            ),
          ),
          IconButton(
            onPressed: () => context.navigateTo(const HomeRoute()),
            icon: const Icon(
              Icons.pause,
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SuperzzleGrid(),
      ),
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
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      children: superzzleCards.cards.map((e) {
        return SuperzzleCard(card: e, id: id++);
      }).toList(),
    );
  }
}

// final myGroup = AutoSizeGroup();

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
        .openCard(id, _flipDuration.ms, 1000.ms, 0.ms);
  }

  void toggleCard(WidgetRef ref) {
    if (card.state == SuperzzleCardState.opened) {
      ref
          .read(superzzleGameStateProvider.notifier)
          .setCardState(id, SuperzzleCardState.closed);
    } else {
      ref
          .read(superzzleGameStateProvider.notifier)
          .setCardState(id, SuperzzleCardState.opened);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget front = Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
          child: Text(
            card.text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ref.watch(settingsStateProvider).fontSize,
            ),
          ),
          // child: AutoSizeText(
          //   card.text,
          //   group: myGroup,
          //   stepGranularity: 2,
          //   maxLines: 1,
          //   style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 60),
          // ),
        ),
      ),
    );

    Widget back = Padding(
      padding: const EdgeInsets.all(0),
      // child: SizedBox.expand(
      // child: FittedBox(
      //   child: Icon(
      //     Icons.church,
      //   ),
      // ),
      // ),
      child: Image.asset("assets/cardBack360.png"),
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
              duration: (_flipDuration / 2).ms,
              begin: 0,
              end: 0.5,
              curve: Curves.easeIn,
            )
            .swap(
              builder: (context, child) => CardContent(
                key: Key("${card.toString()}D"),
                card: card,
                id: id,
                child: front,
              )
                  .animate()
                  .flipH(
                      begin: -0.5,
                      end: 0,
                      duration: (_flipDuration / 2).ms,
                      curve: Curves.easeOut)
                  .toggle(
                builder: (context, value, child) {
                  final isMatched = card.state == SuperzzleCardState.matched;
                  final isClose = card.state == SuperzzleCardState.incorrect;
                  final isDone = !value;

                  final target = (isDone && isMatched) ? 1.0 : 0.0;

                  return child
                      .animate(target: target)
                      .elevation(
                        color: Colors.greenAccent.withOpacity(0.5),
                        end: 10,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      )
                      .shimmer(duration: 800.ms)
                      .animate(target: (isDone && isClose) ? 1.0 : 0.0)
                      .shake();
                },
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
