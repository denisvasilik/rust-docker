FROM ubuntu:18.04

ARG TOOLCHAIN=nightly-2020-07-12
ARG TARGET=armv7-unknown-linux-gnueabihf

RUN groupadd -g 1000 rust && \
    useradd -u 1000 -g 1000 rustecean && \
    apt-get update && \
    apt-get install build-essential \
		    gcc-arm-linux-gnueabihf \
                    curl -y

WORKDIR /home/rustecean

COPY build.sh build.sh

RUN chown rustecean:rust /home/rustecean -R && \
    echo "PATH=\"/home/rustecean/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\"" > /etc/environment && \
    echo "source /home/rustecean/.cargo/env" >> /home/rustecean/.bashrc

USER rustecean

RUN curl https://sh.rustup.rs -o install_rustup.sh && \
    chmod +x install_rustup.sh && \
    ./install_rustup.sh -y

RUN . .cargo/env && \
    rustup default ${TOOLCHAIN} && \
    rustup component add llvm-tools-preview && \
    rustup target add ${TARGET}

CMD ["./build.sh"]
