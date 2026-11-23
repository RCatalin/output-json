# output-json

A lightweight JSON log generator for exercising log pipelines, parsers, and ingestion systems. It continuously writes realistic, structured sample events so you can check how your pipeline handles changing values and nested fields.

## What it generates

Every second, the script appends one JSON object to each of these files:

- `/nexmo/event/event.log`
- `/nexmo/cdr/cdr.log`

Each line is an independent JSON record containing:

| Field | Description |
| --- | --- |
| `colour` | A randomly selected color |
| `hostname` | The machine or container hostname |
| `version` | The contents of the local `VERSION` file |
| `timestamp` | The time the record was generated |
| `words` | A map of zero to five randomly selected words |

The two files are generated independently, so their records can differ. Each record is pretty-printed and followed by a newline, making the output easy to inspect while exercising log shippers and ingestion pipelines.

## Run locally

Requires Python 3. The script uses only the Python standard library.

```bash
git clone https://github.com/delutz/output-json.git
cd output-json
python3 output_json.py
```

The process runs continuously and creates the output directories as needed. Stop it with **Ctrl+C**. Run it from the repository directory so it can read the `VERSION` file.

## Run with Docker

Build the image and start the generator:

```bash
docker build -t output-json .
docker run --rm output-json
```

To keep generated logs after the container exits, mount a host directory at `/nexmo`:

```bash
mkdir -p ./output
docker run --rm -v "$PWD/output:/nexmo" output-json
```

The logs will appear under `./output/event/event.log` and `./output/cdr/cdr.log`.

## Example record

```json
{
  "colour": "blue",
  "hostname": "pipeline-worker-1",
  "version": "1.5.16",
  "timestamp": "2024-01-01 12:00:00.123456",
  "words": {
    "0": "cassette",
    "1": "rocket"
  }
}
```

Values are randomized, so your output will vary.

## Configuration

The output paths and one-second write interval are currently defined in `output_json.py`. The generator is intentionally small and has no command-line options or third-party runtime dependencies.

## License

No license is currently included. Add a `LICENSE` file if you want to specify terms for reuse and contribution.
