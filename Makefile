WARNMSG=echo "check error, may need upgrade"
GITHUB_DIR=$$HOME/code/src/github.com
DOTFILES_DIR=$(GITHUB_DIR)/dotfiles.git


all:  install_tools install_files
install_files: install_zsh install_fzf install_vim_files install_tmux_files install_vim_files install_grv_files
install_tools: install_zsh install_brew_list  install_pip_list  install_sdkman install_aws_kubectl_aws_iam_authentication

clean:
	rm -rf build

update_remote_url_to_ssh:
	git remote set-url origin git@github.com:LaurentKrishnathas/dotfiles.git

#### tools ################################################################################################
install_brew:
	brew doctor
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

install_sdkman:
	curl -s "https://get.sdkman.io" | bash
	source ~/.sdkman/bin/sdkman-init.sh \
	&& echo yes | sdk install gradle


install_sdkman_all:
	curl -s "https://get.sdkman.io" | bash
	source ~/.sdkman/bin/sdkman-init.sh \
	&& echo yes | sdk install groovy \
	&& echo yes | sdk install gradle \
	&& echo yes | sdk install grails \
	&& echo yes | sdk install infrastructor \
	&& echo yes | sdk install springboot

install_zsh:
	rm -rf $$HOME/.zshrc
	rm -rf $(GITHUB_DIR)/oh-my-zsh.git

	ln -s $(DOTFILES_DIR)/bash/zshrc.bash $$HOME/.zshrc
	git clone https://github.com/robbyrussell/oh-my-zsh.git $(GITHUB_DIR)/oh-my-zsh.git
	ln -s  $(DOTFILES_DIR)/bash/oh-my-zsh.bash $(GITHUB_DIR)/oh-my-zsh.git/oh-my-zsh.bash

install_fzf:
	rm -rf $(GITHUB_DIR)/fzf.git
	rm -rf $$HOME/.fzf.bash
	rm -rf $$HOME/.fzf.zsh
	git clone --depth 1 https://github.com/junegunn/fzf.git $(GITHUB_DIR)/fzf.git
	$(GITHUB_DIR)/fzf.git/install --all

install_jenkins:
	mkdir -p $$HOME/bin
	rm -rf $$HOME/bin/jenkins
	rm -rf $$HOME/bin/jenkins-cli.jar
#	wget not working probably antivirus is fiddling with it
#	wget -o $$HOME/bin/jenkins-cli.jar $$JENKINS_URL/jnlpJars/jenkins-cli.jar
	ln -s  $(DOTFILES_DIR)/lib/jenkins-cli.jar $$HOME/bin/jenkins-cli.jar
	ln -s  $(DOTFILES_DIR)/bash/jenkins.bash $$HOME/bin/jenkins


install_zaw:
	rm -rf $(GITHUB_DIR)/zaw.git
	git clone git://github.com/zsh-users/zaw.git $(GITHUB_DIR)/zaw.git

install_vim_files:
	rm -rf $$HOME/.vimrc
	rm -rf $$HOME/.ideavimrc
	ln -s $(DOTFILES_DIR)/config/vim/vimrc $$HOME/.vimrc
	ln -s $(DOTFILES_DIR)/config/vim/ideavimrc $$HOME/.ideavimrc
	vim  +PlugInstall +:qall

install_tmux_files:
	rm -rf $$HOME/.tmux.conf
	ln -s $(DOTFILES_DIR)/config/tmux/tmux.conf $$HOME/.tmux.conf

install_grv_files:
	rm -rf $$HOME/.config/grv
	mkdir -p $$HOME/.config/grv
	ln -s $(DOTFILES_DIR)/config/grv/grvrc $$HOME/.config/grv/grvrc

install_brew_list:
	brew update
	brew install grv || $(WARNMSG)
	brew install cheat 	|| $(WARNMSG)	# shorter man pages
	brew install colordiff || $(WARNMSG)
	brew install fasd	|| $(WARNMSG) # command line navigation utilities
	brew install ctags || $(WARNMSG)
	brew install git || $(WARNMSG)
	brew install git-extras || $(WARNMSG)
	brew install git-flow || $(WARNMSG)
	brew install htop-osx || $(WARNMSG)
	brew install httpie || $(WARNMSG)
	brew install jq		|| $(WARNMSG) # format json
	brew install tmux  || $(WARNMSG)  # terminal multiplexer
	brew install tree || $(WARNMSG)
	brew install wget || $(WARNMSG)
	brew install zsh || $(WARNMSG)
	brew install zsh-completions || $(WARNMSG)
	brew install pwgen  || $(WARNMSG)# generate password: genpasswd n
	brew install pstree || $(WARNMSG)
	brew install packer || $(WARNMSG) #http://www.parallels.com/download/pvsdk/ needed for build
	brew install node || $(WARNMSG)
	brew install ack || $(WARNMSG)
	brew install fzf || $(WARNMSG)
	brew install blueutil || $(WARNMSG) #commandline bluetooth control
	#brew cask install google-chrome
	brew install python || $(WARNMSG)
	brew install watch || $(WARNMSG)
	brew install node@8 || $(WARNMSG)
	brew install yarn || $(WARNMSG)
	brew install golang dep || $(WARNMSG)
	brew install python3 pipenv || $(WARNMSG)
	brew install reattach-to-user-namespace || $(WARNMSG)
	brew install the_silver_searcher   || $(WARNMSG)
	brew cask install spectacle || $(WARNMSG)
	brew cask install dropbox	 || $(WARNMSG)
	brew cask install iterm2 || $(WARNMSG)
	brew cask install visual-studio-code || $(WARNMSG)
	brew cask install sourcetree  || $(WARNMSG)
	brew cask install postman   || $(WARNMSG)
	brew cask install virtualbox  || $(WARNMSG)
	brew cask install vagrant  || $(WARNMSG)
	brew cask install vagrant-manager  || $(WARNMSG)
	brew cask install aws-vault || $(WARNMSG)
	brew install unrar || $(WARNMSG)
	brew install Graphviz || $(WARNMSG)
	brew install warrensbox/tap/tfswitch || true #choosing different terraform versions
	brew install kubectx || $(WARNMSG)
	brew install subversion@1.8 || $(WARNMSG)
#	brew install ctop || $(WARNMSG)

install_minikube:
	brew install kubernetes-cli
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
	brew tap jenkins-x/jx
	brew install jx
	brew install kubernetes-helm

install_node_list:
#	rm -rf  $$NPM_PACKAGES
	mkdir -p $$NPM_PACKAGES
	cd $$NPM_PACKAGES && pwd && npm install  tldr
	cd $$NPM_PACKAGES && npm install  yo
	cd $$NPM_PACKAGES && npm install  grunt-cli
	cd $$NPM_PACKAGES && npm install  bower
	cd $$NPM_PACKAGES && npm install  generator-angular
	cd $$NPM_PACKAGES && npm install  json2yaml
	cd $$NPM_PACKAGES && npm install  serverless
	tldr --version

install_pip_list:
	easy_install --user pip || $(WARNMSG)
	pip install --user glances || $(WARNMSG)		# show cpu mem realtime report
	pip install --user warchdog || $(WARNMSG)		#utility to watch filesystem for changes
	pip install --user ansible --quiet || $(WARNMSG)
	pip install --user virtualenv || $(WARNMSG)
	cd /tmp/ && curl -O https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py --user
	pip3 install awscli --upgrade --user


install_fonts:
	brew tap caskroom/fonts
	brew cask install font-fira-code
	pip install --user powerline-status


install_zsh_autosuggestion:
	git clone https://github.com/zsh-users/zsh-autosuggestions "$(GITHUB_DIR)/zsh-autosuggestions"

install_powerline:
    git clone https://github.com/powerline/fonts.git --depth=1 /tmp/fonts
	cd /tmp/fonts && ./install.sh

install_spaceship:
	if [ -d "$$ZSH/custom/themes/spaceship-prompt" ]; then echo "Warning deleting, Continue ?";read; fi
	echo "ZSH_CUSTOM=$$ZSH/custom"
	mkdir -p "$$ZSH/custom/themes/spaceship-prompt"
	rm -rf "$$ZSH/custom/themes/spaceship-prompt"
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$$ZSH/custom/themes/spaceship-prompt"
	if [ -f "$$ZSH/custom/themes/spaceship.zsh-theme" ]; then echo "Warning deleting, Continue ?";read; fi
	rm -rf "$$ZSH/custom/themes/spaceship.zsh-theme"
	ln -s "$$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$$ZSH/custom/themes/spaceship.zsh-theme"

download-docker-images:
	docker pull tomcat


change2zsh:
	chsh -s /bin/zsh

move_sreenshotdir2downloads:
	defaults write com.apple.screencapture location $$HOME/Downloads
	killall SystemUIServer

install_crontab:
	crontab -l || true
	crontab -r || true
	crontab -l || true
	crontab $$PWD/config/crontab/crontab.bash
	crontab -l
	mkdir -p /tmp/crontab
	echo "hello">>/tmp/crontab/test.log
	ls -la /tmp/crontab
	tail -f /tmp/crontab/*

####################################################################################################

INSTALL_DIR=build
install_aws_kubectl_aws_iam_authentication:
	mkdir -p $(INSTALL_DIR)
	curl -o $(INSTALL_DIR)/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/kubectl
	curl -o $(INSTALL_DIR)/kubectl.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/kubectl.sha256
#	openssl sha -sha256  $(INSTALL_DIR)/kubectl
	chmod +x $(INSTALL_DIR)/kubectl
	$(INSTALL_DIR)/kubectl version --short --client
	curl -o $(INSTALL_DIR)/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/aws-iam-authenticator
	curl -o $(INSTALL_DIR)/aws-iam-authenticator.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/aws-iam-authenticator.sha256
	openssl sha -sha256 $(INSTALL_DIR)/aws-iam-authenticator
	chmod +x $(INSTALL_DIR)//aws-iam-authenticator
	mv $(INSTALL_DIR)/kubectl $$HOME/bin/
	mv $(INSTALL_DIR)/aws-iam-authenticator $$HOME/bin/


IAM_ROLE=arn:aws:iam::101999902141:role/dotmatics-devops-eks
eks_create_cluster:
	aws eks create-cluster --name devel --role-arn $(IAM_ROLE) --resources-vpc-config subnetIds=ubnet-0985ff0ff62d7b166,subnet-047725a76feb1618d,subnet-006c084e1ae3ee1a0,securityGroupIds=sg-05b45c8a464cfdf5b --region eu-west

eks_endpoint:
	aws eks describe-cluster --name devel  --query cluster.endpoint --output text

eks_certificateAuthority:
	aws eks describe-cluster --name devel  --query cluster.certificateAuthority.data --output text

eks_create_kubeconfig:
	mkdir -p $$HOME/.kube

dgoss_run:
	cd infra/docker/dgoss && dgoss run -e JENKINS_OPTS="--httpPort=8080 --httpsPort=-1" -e JAVA_OPTS="-Xmx1048m" jenkins:alpine


dgoss_edit:
	cd infra/docker/dgoss && dgoss edit -p 8080:80 nginx:1.11.10

####################################################################################################
IMG_DIR=IMG_DIR_not_defined
DOCKERFILE=infra/docker/image/$(IMG_DIR)/Dockerfile
TAG=laurentkrishnathas/$(IMG_DIR):latest

build_docker_image:
	@echo "usage : "
	@echo "/> make build_docker_image IMG_DIR=golang-tmp"
	@echo "/> make build_docker_image IMG_DIR=golang-tmp DOCKERFILE=~/infra/docker/image/golang-tmp/sample.Dockerfile"
	@echo "..."
	docker build --tag=$(TAG) --rm=false -f $(DOCKERFILE)  .

test_docker_image: build_docker_image
	docker run \
		-it \
		-v ~/Downloads:/downloads \
		$(TAG)

test_docker_image_dockerdaemon: build_docker_image
	docker run \
		-it \
		-v ~/Downloads:/downloads \
		-v /var/run/docker.sock:/var/run/docker.sock:ro \
		$(TAG)

test_docker_image_awsconfig: build_docker_image
	docker run \
		-it \
		-v ~/.aws:/root/.aws \
		-v ~/Downloads:/downloads \
		-e AWS_PROFILE=devops-dev \
		-e AWS_REGION=eu-west-1 \
		$(TAG)

GOSS_PATH=infra/docker/image/$(IMG_DIR)/goss.yaml
test_docker_image_dgoss: build_docker_image
	GOSS_PATH=$(GOSS_PATH) \
	dgoss run \
		-it \
		-v ~/Downloads:/downloads \
		$(TAG)

FILE=FILE_not_defined
GOOS=windows
GOARCH=386
build_golang_file_to_binary:
	mkdir -p $$PWD/build/bin
	ls -la $$PWD/build/bin
	docker run -it \
			-v $$PWD/$(FILE):/code/$(FILE) \
			-v $$PWD/build/bin:/workspace \
			-w /workspace golang:1.9.2-alpine3.7 sh -c  "GOOS=$(GOOS) GOARCH=$(GOARCH) go build /code/$(FILE)"

	ls -la $$PWD/build/bin


####################################################################################################
STACK_ENV=dev

STACK ?= stack_not_defined

STACK_NAME=$(STACK)-$(STACK_ENV)

GRAILS_ENV=rc

ALL_ENVS=STACK_NAME=$(STACK_NAME) \
		 GRAILS_ENV=$(GRAILS_ENV) \
		 STACK_ENV=$(STACK_ENV)

stack_deploy:
	$(ALL_ENVS) docker stack deploy --with-registry-auth  -c infra/docker/stack/$(STACK)/$(STACK).yml -c infra/docker/stack/$(STACK)/$(STACK)-$(ENV).yml $(STACK_NAME)

stack_rm:
	docker stack rm $(STACK_NAME)

stack_logs:
	docker service logs $(STACK_NAME)

stack_debug:
	date
	@echo ""
	docker stack ls
	@echo ""
	docker ps
	@echo ""
	docker stats --no-stream
	@echo ""
	docker service ls
	@echo ""
	docker stack ps $(STACK_NAME)
	@echo ""


stack_watch:
	echo "running watch ..."
	watch -n 2 make stack_debug



install_awscli_sessionmanager_plugin:
#	mkdir -p build/ssm
#	curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac/sessionmanager-bundle.zip" -o "build/ssm/sessionmanager-bundle.zip"
#	unzip build/ssm/sessionmanager-bundle.zip -d build/ssm
	sudo build/ssm/sessionmanager-bundle/install -i /usr/local/sessionmanagerplugin -b /usr/local/bin/session-manager-plugin

BUILDER_IMAGE=dotfiles-builder:lastest
TARGET=make build
build/docker/image:
	docker build -t $(BUILDER_IMAGE) --rm=false -f infra/docker/image/builder/Dockerfile .

build:
	echo "RAS"

build/in/docker: build/docker/image
	docker run -v $$HOME/.gradle:/home/gradle/.gradle -v $$PWD:/code -w /code $(BUILDER_IMAGE) $(TARGET)

GO_FILE=sample.go
GO_DIR=
run/golang/script:
	docker build -t devops-golang:1.0 --rm=false -f infra/docker/image/golang/Dockerfile .
	 docker run -it \
		-e "AWS_SECURITY_TOKEN=${AWS_SECURITY_TOKEN}"\
	 	-e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
	 	-e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
	 	-v $$PWD:/code \
	 	-w /code/src/main/golang/$(GO_DIR) \
	 	devops-golang:1.0 go run ${GO_FILE}

idea:
	rm -rf .idea
	rm -rf dotfiles.iml
	rm -rf dotfiles.ipr
	rm -rf dotfiles.iws
#	./gradlew clean cleanidea idea


debug:
	go run src/main/golang/hello.go
	echo "after"


debug2:
	go build src/main/golang/hello.go
	./hello
	echo "after"
