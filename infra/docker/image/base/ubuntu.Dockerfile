# @author Laurent Krishnathas
FROM ubuntu:18.04

LABEL maintainer="Laurent Krishnathas <lkdevjobs@googlemail.com>"
LABEL description="ubuntu dev setup"

RUN apt-get update  && apt-get install -y \
    curl \
    exuberant-ctags \
    git \
    git-core \
    httpie \
    jq \
    iputils-ping \
    make \
    python3 \
    python \
    rake \
    ruby \
    subversion \
    silversearcher-ag \
    sudo \
    tree \
    tmux \
    unzip \
    vim \
    wget \
    zsh

# installing omyzsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || echo "no idea why the return value is 1" &&\
    chsh -s `which zsh`

# installing go
ENV GOROOT=/usr/local/go
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH
ENV GOLANG_VERSION 1.9.2
RUN wget -q https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz &&\
    tar -xf go${GOLANG_VERSION}.linux-amd64.tar.gz &&\
    mv go /usr/local &&\
    export GOROOT=/usr/local/go &&\
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH &&\
    go version &&\
    go env

#installing https://github.com/carlhuda/janus dotfiles dependancy on rake ruby
RUN curl -L https://bit.ly/janus-bootstrap | bash &&\
    mkdir -p ~/.janus

# fzf vim plugin is installed by wickett but commandline is not working so the following
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/gits/.fzf && yes | ~/gits/.fzf/install

# powerline depend on python3
RUN git clone https://github.com/vim-airline/vim-airline ~/.janus/vim-airline &&\
    git clone https://github.com/vim-airline/vim-airline-themes  ~/.janus/vim-airline-themes

# the following setting needed to enable colors in vim
RUN echo "set t_Co=256" >> ~/.vimrc.after &&\
    echo "let g:airline_powerline_fonts = 1" >> ~/.vimrc.after

RUN wget -O /usr/local/bin/grv  https://github.com/rgburke/grv/releases/download/v0.1.3/grv_v0.1.3_linux64 && \
    chmod +x /usr/local/bin/grv  &&\
    mkdir -p $HOME/.config/grv  &&\
    echo "set theme classic">/$HOME/.config/grv/grvrc &&\
    curl https://www.teleconsole.com/get.sh | sh  &&\
    cd /tmp && curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && unzip awscli-bundle.zip && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws



ENTRYPOINT ["/bin/zsh", "-c"]
CMD ["zsh"]

LABEL image_name="laurent_krishnathas/ubuntu"
LABEL image_version="latest"

