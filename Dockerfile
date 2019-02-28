FROM golang:1.11.5 as go
WORKDIR /go/src/cwj.com/start_ci_test
COPY ./ /go/src/cwj.com/start_ci_test
RUN go get github.com/astaxie/beego \
    && mkdir -p build \
    && go build -v -o build/main \
    && cp -fr ./views build \
    && cp -fr ./static build \
    && cp -fr ./conf build


FROM nginx:1.15.8-alpine

RUN mkdir -p /app
COPY --from=go /go/src/cwj.com/start_ci_test/build /app
CMD ["sh", "-c", "/app/main"]