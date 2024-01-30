FROM debian:12 AS build

RUN apt-get update && apt-get install -y build-essential cmake zlib1g-dev libssl-dev

WORKDIR /

COPY h2o h2o

WORKDIR /h2o/build

RUN cmake .. && make && make install


FROM debian:12

RUN apt-get update && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local /usr/local

CMD [ "h2o" ]
