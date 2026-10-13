# syntax=docker/dockerfile:1
# SPDX-FileCopyrightText: 2026 Kaio Cunha
# SPDX-License-Identifier: MIT-0

# Build a static binary.
FROM golang:1.25-alpine AS build
WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/service .

# Run it as a non-root user on a minimal base.
FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /out/service /service
ENV PORT=8080
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["/service"]
