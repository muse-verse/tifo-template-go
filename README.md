<!--
SPDX-FileCopyrightText: 2026 Kaio Cunha
SPDX-License-Identifier: MIT-0
-->

# tifo-template-go

The golden-path Go service that `tifo init` creates. It is a GitHub template repository:
every new service starts from its default branch.

## What is in it

- `main.go`: an HTTP server on `$PORT` (default `8080`) with `GET /healthz` for liveness and
  readiness probes, JSON logs, and a graceful shutdown on `SIGINT` or `SIGTERM`.
- `Dockerfile`: a static build on `golang:1.25-alpine`, run as a non-root user on
  `gcr.io/distroless/static-debian12:nonroot`.
- `.gitignore`: ignores `.tifo/`, where tifo keeps its local state. That state lives on the
  `tifo/state` branch, never on `main`.

## Run it

```sh
go test ./...
go run .                       # then: curl localhost:8080/healthz
docker build -t service .
docker run --rm -p 8080:8080 service
```

## After tifo creates your repository

Rename the module in `go.mod` from `service` to your repository path, for example
`github.com/<owner>/<name>`, and add your routes next to `/healthz` in `newMux`.

## License

The starter files of this template are MIT-0: use, change and ship them with no attribution. The
SPDX header of each file says so, and the license text is in [LICENSES/MIT-0.txt](LICENSES/MIT-0.txt).
The code that you add is yours, under the license that you choose.
