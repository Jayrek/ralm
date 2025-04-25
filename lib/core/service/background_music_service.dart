// import 'package:audioplayers/audioplayers.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:audio_session/audio_session.dart';

class BackgroundMusicService {
  //   static final BackgroundMusicService _instance =
  //       BackgroundMusicService._internal();
  //   factory BackgroundMusicService() => _instance;
  //   BackgroundMusicService._internal();

  //   final AudioPlayer _player = AudioPlayer();
  //   bool _isPlaying = false;

  //   Future<void> init() async {
  //     await _player.setReleaseMode(ReleaseMode.loop); // Loop the audio
  //     await _player.setSource(
  //       AssetSource('asset://assets/audio/audio_stream.mp3'),
  //     ); // Set your audio file
  //   }

  //   Future<void> play() async {
  //     if (!_isPlaying) {
  //       _isPlaying = true;
  //       await _player.play(
  //         AssetSource('asset://assets/audio/audio_stream.mp3'),
  //       ); // Start playing audio
  //     }
  //   }

  //   Future<void> stop() async {
  //     _isPlaying = false;
  //     await _player.stop(); // Stop the audio
  //   }

  //   bool get isPlaying => _isPlaying;

  // just_audio
  static final BackgroundMusicService _instance =
      BackgroundMusicService._internal();
  factory BackgroundMusicService() => _instance;
  BackgroundMusicService._internal();

  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;

  Future<void> init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
    await _player.setLoopMode(LoopMode.one); // Loop the audio
    await _player.setAsset(
      'assets/audio/audio_stream.mp3',
    ); // Add your audio file in assets
  }

  Future<void> play() async {
    if (!_isPlaying) {
      _isPlaying = true;
      await _player.play();
    }
  }

  Future<void> stop() async {
    _isPlaying = false;
    await _player.stop();
  }

  bool get isPlaying => _isPlaying;
}
