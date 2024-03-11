FROM alpine AS base

ARG TAG=latest
RUN [[ "$TAG" = "latest" ]] && \
    TAG=$(wget -qO- https://api.github.com/repos/ashphy/jsonpath-online-evaluator/tags | sed -n 's/.*"name": "\(.*\)".*/\1/p' | head -n 1) || \
    wget https://github.com/ashphy/jsonpath-online-evaluator/releases/download/${TAG}/jsonpath-online-evaluator.zip && \
    unzip jsonpath-online-evaluator.zip -d /jsonpath-online-evaluator

FROM lipanski/docker-static-website

COPY --from=base /jsonpath-online-evaluator .
