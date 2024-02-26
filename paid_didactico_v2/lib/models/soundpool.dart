import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SoundPool {
  final Soundpool pool = Soundpool(streamType: StreamType.notification);

  final String _assetCorrect = 'assets/audios/correct.mp3';
  final String _assetError = 'assets/audios/negative.mp3';
  final String _assetLevelUp = 'assets/audios/levelup.mp3';
  final String _assetSelect = 'assets/audios/select.mp3';
  final String _assetFinal = 'assets/audios/success.mp3';

  late int _soundCorrect;
  late int _soundError;
  late int _soundLevelUp;
  late int _soundSelect;
  late int _soundFinal;

  SoundPool() {
    configSound();
  }

  void configSound() async {
    _soundCorrect = await setupSoundId(_assetCorrect);
    _soundError = await setupSoundId(_assetError);
    _soundLevelUp = await setupSoundId(_assetLevelUp);
    _soundSelect = await setupSoundId(_assetSelect);
    _soundFinal = await setupSoundId(_assetFinal);
  }

  Future<int> setupSoundId(String assertConfig) async {
    return await rootBundle.load(assertConfig).then((ByteData soundData) {
      return pool.load(soundData);
    });
  }

  void playSoundCorrect() async {
    await pool.play(_soundCorrect);
  }

  void playSoundError() async {
    await pool.play(_soundError);
  }

  void playSoundSelect() async {
    await pool.play(_soundSelect);
  }

  void playSoundLevelUp() async {
    await pool.play(_soundLevelUp);
  }

  void playSoundFinal() async {
    await pool.play(_soundFinal);
  }
}
