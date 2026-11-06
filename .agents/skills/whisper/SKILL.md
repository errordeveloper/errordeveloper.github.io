---
name: whisper
description: Transcribe local audio or video using whisper.cpp, prioritizing larger Whisper models, transcription accuracy, and manageable memory use. Use for voice notes, recordings, transcripts, or subtitles.
---

# Whisper

## Model and memory preferences

- Use `whisper.cpp` (`whisper-cli`), not the Python `openai-whisper` CLI. Default to `large-v3`; honor explicit model choices. Prefer accuracy over speed.
- Start with the unquantized GGML `large-v3` model when resources permit. Under memory pressure, prefer a quantized `large-v3` such as `large-v3-q5_0` before switching to a smaller or turbo model. Quantization can affect accuracy: disclose it and check difficult passages. Never silently downgrade.
- Run one transcription at a time. For long recordings, consider overlapping audio chunks and reconcile duplicated text and timestamp offsets. Chunking reduces audio-buffer memory but does not shrink the model.
- Prefer Metal acceleration on Apple Silicon when the installed build supports it; inspect startup logs to confirm. `--no-gpu` is a compatibility fallback, not a guaranteed reduction in memory use. PyTorch MPS settings do not control whisper.cpp.
- This workflow does not enforce a memory cap. If the user specifies a budget, use an available memory monitor or guard and stop when the budget is exceeded; do not claim a strict ceiling from periodic polling. Do not silently continue with an unmonitored run if enforcement was requested. macOS `ulimit -m` is not a dependable hard cap.

## Environment and models

Use the project's existing environment. For a Nix flake providing `whisper-cpp` and FFmpeg, enter `nix develop` or prefix commands with `nix develop -c`. Check `whisper-cli --help` for the installed version's flags. Nixpkgs enables Metal by default on Apple Silicon in the version inspected for this project; other builds may differ.

Whisper.cpp requires GGML `.bin` models, not Python Whisper `.pt` checkpoints. Reuse a cache outside the repository. The Nix package provides `whisper-cpp-download-ggml-model`; another installation may instead provide upstream's `models/download-ggml-model.sh`. Inspect its usage before substituting it.

Inside `nix develop`, download the selected model only if missing:

```sh
whisper_model_dir="${XDG_CACHE_HOME:-$HOME/.cache}/whisper.cpp"
mkdir -p "$whisper_model_dir"
whisper-cpp-download-ggml-model large-v3 "$whisper_model_dir"
```

Check that a cached model is complete and loads successfully; downloader existence checks alone do not verify integrity. For an interrupted download, preserve or remove the partial file before retrying. For the memory-saving variant, use `large-v3-q5_0` and the matching `ggml-large-v3-q5_0.bin` path. Keep model weights out of Git and published site content. Downloading weights does not require uploading audio.

## Transcribe

Preserve the original media. Choose a fresh output directory or the user's requested destination, outside published site content unless publication is requested. Convert to 16 kHz mono, 16-bit PCM WAV for predictable input support, especially on macOS where the Nix build lacks integrated FFmpeg decoding. For recordings with distinct speakers on separate channels, consider transcribing channels separately instead of mixing them.

Example inside `nix develop`, with a fresh output directory:

```sh
mkdir -p "transcripts/recording"
ffmpeg -nostdin -n -i "recording.m4a" -ar 16000 -ac 1 -c:a pcm_s16le \
  "transcripts/recording/input.wav"
whisper-cli \
  --model "$whisper_model_dir/ggml-large-v3.bin" \
  --file "transcripts/recording/input.wav" \
  --language auto \
  --beam-size 5 --best-of 5 --temperature 0 --temperature-inc 0.2 \
  --output-txt --output-srt --output-json-full \
  --output-file "transcripts/recording/transcript"
```

Transcription is the default; add `--translate` only when English translation is requested. Set `--language` to the known spoken language, otherwise use `auto` explicitly (the CLI may default to English). Do not infer the language solely from the conversation. Beam size 5 and temperature fallback are starting settings, not a guarantee of correctness.

Use `--prompt` for known names and technical vocabulary, never an imagined transcript. Keep default silence and repetition thresholds initially. Avoid copying Python CLI flags such as `--task`, `--fp16`, or `--output_dir` into whisper.cpp commands.

## Review and deliver

Inspect missing passages, repetition, implausible terms, and text during silence. Use JSON diagnostics and timestamps to locate suspect passages; token scores are not calibrated confidence percentages. Check names and numbers against the recording where playback is available and supplied context. Never claim to have listened if you have not.

Retry suspect intervals with surrounding context and a specific adjustment; for repetition loops, consider `--max-context 0`. Preserve the first output. Stop when retries yield no useful improvement, and mark unresolved passages with timestamps rather than inventing speech.

Keep raw outputs separate from edited transcripts. Do not silently summarize or turn a voice note into a post. Report output paths, model and quantization, language, and unresolved uncertainty. Identify an unreviewed machine transcript as such. Keep processing local unless the user requests a remote service.

## References

- [whisper.cpp documentation](https://github.com/ggml-org/whisper.cpp#readme): backends, memory use, and quantization.
- [CLI implementation](https://github.com/ggml-org/whisper.cpp/blob/master/examples/cli/cli.cpp): flags and defaults; prefer installed help for version-specific behavior.
- [Model downloader](https://github.com/ggml-org/whisper.cpp/blob/master/models/download-ggml-model.sh): supported model names and download sources.
