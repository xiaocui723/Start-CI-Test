FROM golang:1.11.5-alpine as go

RUN mkdir -p ./build \
    && go build -v -o ./build/main \
    && cp -fr ./views ./build \
    && cp -fr ./static ./build \
    && cp -fr ./conf ./build \


FROM nginx:1.15.8-alpine

RUN mkdir -p /app
COPY --from=go ./build /app
CMD ["sh", "-c", "/app/main"]