// This is a minimal example demonstrating a play/pause button and a seek bar.
// More advanced examples demonstrating other features can be found in the same
// directory as this example in the GitHub repository.

import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:activity_ring/activity_ring.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

String form = "Meditation";
String musicUrl =
    "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3";

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> with WidgetsBindingObserver {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(musicUrl)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Palette().bluebg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.yellow),
                  borderRadius: BorderRadius.circular(10)),
              minWidth: w / 2 - 40,
              color: Colors.yellow,
              child: Text(
                "Share on Snapchat",
                style: TextStyle(color: Palette().bluebg),
              ),
              onPressed: () async {
                const url =
                    'https://nightsky-api.herokuapp.com/meditation_stats';

                // if (await canLaunch(url)) {
                //   await launch(url, forceWebView: true, enableJavaScript: true);
                // } else {
                //   throw 'Could not launch $url';
                // }

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Webview(url)));
              },
            ),
            SizedBox(
              height: 10,
            ),

            // Display play/pause button and volume/speed sliders.
            ControlButtons(_player),
            // Display seek bar. Using StreamBuilder, this widget rebuilds
            // each time the position, buffered position or duration changes.
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                      positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: _player.seek,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Opens volume slider dialog

            Ring(
              percent: 100,
              color: RingColorScheme(
                  ringColor: Palette().auroraGreen.withOpacity(0.8)),
              radius: 90,
              width: 5,
              child: Ring(
                percent: 100,
                color: RingColorScheme(ringColor: Palette().auroraGreen),
                radius: 80,
                width: 5,
                child: StreamBuilder<PlayerState>(
                  stream: player.playerStateStream,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;
                    final processingState = playerState?.processingState;
                    final playing = playerState?.playing;
                    if (processingState == ProcessingState.loading ||
                        processingState == ProcessingState.buffering) {
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        width: 64.0,
                        height: 64.0,
                        child: CircularProgressIndicator(
                          backgroundColor: Palette().auroraGreen,
                        ),
                      );
                    } else if (playing != true) {
                      return IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          color: Palette().auroraGreen,
                        ),
                        iconSize: 64.0,
                        onPressed: player.play,
                      );
                    } else if (processingState != ProcessingState.completed) {
                      return IconButton(
                        icon: Icon(
                          Icons.pause,
                          color: Palette().auroraGreen,
                        ),
                        iconSize: 64.0,
                        onPressed: player.pause,
                      );
                    } else {
                      return IconButton(
                        icon: Icon(Icons.replay, color: Palette().auroraGreen),
                        iconSize: 64.0,
                        onPressed: () => player.seek(Duration.zero),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    this.duration,
    this.position,
    this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;
  SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(top: 150, right: 20, left: 20),
        child: Container(
            color: Colors.transparent,
            width: w,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Palette().auroraGreen.withOpacity(0.3),
                ),
                width: w - 60,
                height: 80,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "     $form",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Stack(
                          children: [
                            SliderTheme(
                              data: _sliderThemeData.copyWith(
                                thumbShape: HiddenThumbComponentShape(),
                                activeTrackColor: Colors.blue.shade100,
                                inactiveTrackColor: Colors.grey.shade300,
                              ),
                              child: ExcludeSemantics(
                                child: Slider(
                                  min: 0.0,
                                  max:
                                      widget.duration.inMilliseconds.toDouble(),
                                  value: min(
                                      widget.bufferedPosition.inMilliseconds
                                          .toDouble(),
                                      widget.duration.inMilliseconds
                                          .toDouble()),
                                  onChanged: (value) {
                                    setState(() {
                                      _dragValue = value;
                                    });
                                    if (widget.onChanged != null) {
                                      widget.onChanged(Duration(
                                          milliseconds: value.round()));
                                    }
                                  },
                                  onChangeEnd: (value) {
                                    if (widget.onChangeEnd != null) {
                                      widget.onChangeEnd(Duration(
                                          milliseconds: value.round()));
                                    }
                                    _dragValue = null;
                                  },
                                ),
                              ),
                            ),
                            SliderTheme(
                              data: _sliderThemeData.copyWith(
                                inactiveTrackColor: Colors.transparent,
                              ),
                              child: Slider(
                                min: 0.0,
                                max: widget.duration.inMilliseconds.toDouble(),
                                value: min(
                                    _dragValue ??
                                        widget.position.inMilliseconds
                                            .toDouble(),
                                    widget.duration.inMilliseconds.toDouble()),
                                onChanged: (value) {
                                  setState(() {
                                    _dragValue = value;
                                  });
                                  if (widget.onChanged != null) {
                                    widget.onChanged(
                                        Duration(milliseconds: value.round()));
                                  }
                                },
                                onChangeEnd: (value) {
                                  if (widget.onChangeEnd != null) {
                                    widget.onChangeEnd(
                                        Duration(milliseconds: value.round()));
                                  }
                                  _dragValue = null;
                                },
                              ),
                            ),
                            Positioned(
                              right: 16.0,
                              bottom: 0.0,
                              child: Text(
                                  RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                          .firstMatch("$_remaining")
                                          ?.group(1) ??
                                      '$_remaining',
                                  style: Theme.of(context).textTheme.caption),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ))));
  }

  Duration get _remaining => widget.duration - widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

void showSliderDialog({
  BuildContext context,
  String title,
  int divisions,
  double min,
  double max,
  String valueSuffix = '',
  // TODO: Replace these two by ValueStream.
  double value,
  Stream<double> stream,
  ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
