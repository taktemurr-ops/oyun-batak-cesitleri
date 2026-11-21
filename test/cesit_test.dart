import 'package:flutter_test/flutter_test.dart';
import 'package:kart_motoru/kart_motoru.dart';
import 'package:oyun_batak_cesitleri/oyun_batak_cesitleri.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('5 çeşit, kimlikler benzersiz, 33 dil', () {
    expect(batakCesitConfigs.length, 5);
    expect(batakCesitConfigs.map((c) => c.gameId).toSet().length, 5);
    expect(batakCesitGroup.title.length, 33);
    for (final c in batakCesitConfigs) {
      expect(c.title.length, 33);
      expect(c.tagline.length, 33);
      for (final s in c.tutorial) {
        expect(s.text.length, 33);
      }
    }
  });

  for (final rules in batakCesitRules) {
    test('${rules.gameId}: bölümler kazanılabilir, el sonuna kadar oynanır', () {
      final planner = LevelPlanner(gameId: rules.gameId, optionalMechanics: const []);
      for (final lv in [1, 300, 12345, 49999]) {
        final gl = rules.build(planner.spec(lv));
        expect(gl.validation.ok, isTrue, reason: '${rules.gameId} $lv');
        final end = TrickGameRules.simulate(gl.puzzle);
        expect(end.phase, TrickPhase.over);
      }
    });
  }
}
