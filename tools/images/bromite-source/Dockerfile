ARG VERSION

FROM uazo/chromium:$VERSION

ARG BROMITE_SHA
ENV BROMITE_SHA=$BROMITE_SHA

ARG HTTP_PROXY
ENV HTTP_PROXY=$HTTP_PROXY
ENV HTTPS_PROXY=$HTTP_PROXY
ENV https_proxy=$HTTP_PROXY

#USER lg
WORKDIR /home/lg/working_dir

RUN sudo chown lg /etc/apt/apt.conf.d/proxy.conf
RUN sudo echo "Acquire::http::Proxy \"$HTTP_PROXY\";" >/etc/apt/apt.conf.d/proxy.conf
RUN sudo apt-get update

COPY apply-bromite-patches.sh .

RUN sudo chmod +x ./apply-bromite-patches.sh && \
    mkdir bromite && \
    cd bromite && \
    git init && \
    git remote add origin https://github.com/uazo/cromite && \
    git fetch origin $BROMITE_SHA && \
    git reset --hard FETCH_HEAD && \
    cd ..

RUN ./apply-bromite-patches.sh

