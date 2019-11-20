FROM debian

ENV RUSTUP_HOME=/usr/local/rustup \
  CARGO_HOME=/usr/local/cargo \
  PATH=/usr/local/cargo/bin:$PATH

RUN apt-get update && \
  apt-get install -y wget git build-essential python3 curl libappindicator1 fuse libgconf-2-4 psmisc lsof procps libasound2 libnss3 libxss1 libxtst6 libgtk-3-0 expect

RUN curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb && dpkg -i keybase_amd64.deb && apt-get install -f

RUN set -eux; \
  \
  url="https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init"; \
  wget "$url"; \
  chmod +x rustup-init; \
  ./rustup-init -y --no-modify-path --default-toolchain nightly; \
  rm rustup-init; \
  chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
  rustup --version; \
  cargo --version; \
  rustc --version;

RUN git clone https://github.com/LoopringSecondary/phase2-bn254 --branch master && \
  cd phase2-bn254/phase2 && \
  cargo build --release

WORKDIR /phase2-bn254/loopring

COPY sftp.credential ./
COPY run_setup.sh ./

CMD bash run_setup.sh