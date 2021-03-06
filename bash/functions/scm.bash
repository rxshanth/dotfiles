#
# @author Laurent Krishnathas
# @year 2019

function commit_push_codecommit {
	commit $*

	echo -e "\e[1;31m/> git push codecommit ?\e[0m"
	read press_key_to_continue
	git push codecommit
}

function commit {
	if  [ -d .svn ]; then
		commitsvn $*
	elif  [ -d .git/svn ]; then
		git svn info>/dev/null  2>&1
		local status_=$?
		if [ $status_ -ne 0 ]; then
			commitgit  $*
		else
			commitgitsvn  $*
		fi
	else
	        echo "checking if git repot ..."
	        git -C ./ rev-parse
			commitgit  $*
	fi
}

function pull {
	if  [ -d .svn ]; then
	    svn update
	elif  [ -d .git/svn ]; then
		git svn info>/dev/null  2>&1
		local status_=$?
		if [ $status_ -ne 0 ]; then
		    git pull
		else
            git svn fetch
            git svn rebase
            git status
		fi
	else
         git pull
	fi
}

function commitgit {
	echo "/> git pull ..."
	git pull
	git branch -a
	git branch -v
	git status
	git diff --staged

	echo -e "\e[1;31m/> git commit -am\"$*\" ?\e[0m"
	read press_key_to_continue
	git commit -m"$*"
	git status
	echo -e "\e[1;31m/> git push ?\e[0m"
	read press_key_to_continue
	git push
	git status
}

function commitgitsvn {
	echo "git svn fetch, git svn rebase ..."
	git svn fetch
	git svn rebase
	git diff --staged
	git branch -a
	git branch -v
	git svn info
	git status

	echo -e "\e[1;31m/>git commit -am\"$*\" ?\e[0m"
	read press_key_to_continue
	git commit -am"$*"

	git status
	git svn dcommit --dry-run
	echo "/>git svn dcommit ? WARNING CHECK IT IS SVN BRANCH, GIT BRANCH MAY COMMIT TO SVN TRUNK"
	read press_key_to_continue
	git svn dcommit
	git svn info
}

function commitsvn {
	svn up
	svn info
	svn status

	echo "/>svn diff ?"
	read press_key_to_continue
	svn diff

	echo "/>svn commit -m\"$*\" ?"
	read press_key_to_continue
	svn commit -m"$*"

	svn status
	svn log -l1 -v
	svn log -l10 -q
}

function fetchrebase {
	git svn fetch
	git svn rebase
	git status
}

function git_clone_tmpdir {	# clone full or partial
	if [[ $1 == *"/tree/master/"* ]]; then
		prefix=$(echo $1 | sed 's/\/tree\/master.*//')
	  suffix=$(echo $1 | sed 's/^.*\/tree\/master\///')
		git_clone_tmpdir_sparse $prefix $suffix
	else
		mkdirtmp
		git clone $1
		idea *
	fi
}

function git_clone_tmpdir_sparse {
	mkdirtmp
	git init
	git remote add -f origin $1
	git config core.sparseCheckout true
	echo "$2">>.git/info/sparse-checkout
	git pull origin master
	idea *
}


