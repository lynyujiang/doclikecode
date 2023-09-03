=========
Hello Git
=========


* Github: https://github.com
* GitHub文档: https://docs.github.com/zh


Git添加多个远程仓库
===================

#. 查看有多少个仓库

    .. code-block:: console

        git remote -v

#. 添加github远程仓库

    .. code-block:: console

        git remote add github https://github.com/lynyujiang/doclikecode.git
        git push -u github master

#. 添加gitee远程仓库

    .. code-block:: console

        git remote add gitee https://gitee.com/lynyujiang/doclikecode.git
        git push -u gitee master

#. 从两个仓库拉取代码

    .. code-block:: console

        git pull

#. 推送代码到两个仓库

    .. code-block:: console

        git push --all

#. 推送代码到github仓库

    .. code-block:: console

        git push github master

#. 推送代码到gitee仓库

    .. code-block:: console

        git push gitee master

git重新提交
===========

    .. code-block:: console

        # 撤销最近n个提交，变成add状态，可以重新commit
        git reset --soft HEAD~n

        # 强制推送到远程
        git push -f

git回滚
=======

    .. code-block:: console

        # 回滚最近n个提交，代码彻底删除了，找不回来
        git reset --hard HEAD~n

        # 强制推送到远程
        git push -f

git 删除某个提交
================

    .. code-block:: console

        git reset --soft HEAD~n # 撤销最近n个提交，变成add状态
        git stash               # 暂存代码
        git reset --hard HEAD~1 # 删除前1一个提交
        git unstash             # 取出代码
        git commit              # 重新提交代码
        git push -f             # 强制推送到远程

从Github一次性克隆所有的仓库
============================

   .. prompt:: bash

        gh auth login

        gh repo list xilinx --limit 1000 | while read -r repo _; do
            gh repo clone "$repo" "$repo"
        done

在docker中运行gitlab
====================

   .. prompt:: bash

        docker run -d                      \
            --name gitlab                  \
            --restart always               \
            -p 8443:443                    \
            -p 9000:9000                   \
            -p 8022:22                     \
            -v ${PWD}/config:/etc/gitlab   \
            -v ${PWD}/logs:/var/log/gitlab \
            -v ${PWD}/data:/var/opt/gitlab \
            gitlab/gitlab-ce

--name           指定窗口的名称
--restart always 出现异常后自动重启
-p               端口映射


git cherry-pick
===============

对于多分支的代码库，将代码从一个分支转移到另一个分支是常见的需求。这时分两种情况，一种是需要另一个分支的所有代码变动，那么就彩合并（git merge），另一种情况是，只需要部分代码的变动（某几个提交），这时可以采用cherry-pick。

git cherry-pick命令的作用，就是将指定的提交（commit）应用于其他分支。

举例来说，代码库有master和feature两个分支。

a - b - c - d       master
     \
      e - f - g     feature

现将提交f应用到master分支。

# 切换到master分支
$ git checkout master

# Cherry pick 操作
$ git cherry-pick f

上面的操作完成以后，代码库就变成了下面的样子：

a - b - c - d - f   master
     \
      e - f - g     feature

从上面可以看到，master分支的末尾增加了一个提交f。

git cherry-pick 命令的参数，不一定是提交的哈希值，分支名也是可以的，表示转移该分支的最新提交。

$ git cherry-pick feature

上面代码表示将feature分支的最近一次提交转移到当前分支。

git cherry-pick 支持一次转移多个提交。

$ git cherry-pick  <HashA> <HashB>

上面命令将A和B两个提交应用到当前分支，这会在当前分支生成两个对应的新提交。

如果想要转移一系列的连续提交，可以使用下面的简便语法。

$ git cherry-pick A..B

上面命令可以转移从A到B的所有提交，它们必须按照正确的顺序放置：提交A必须早于提交B，否则命令将失败，但不会报错。

注意： 使用上面的命令，提交A将不会包含在cherry pick中，如果要包含提交A，可以使用下面的语法。

$ git cherry-pick A^..B


撤消工作区的修改（尚未进行git add操作）
======================================

因为还没执行git add命令添加到暂存区，所以只需要通过git checkout -- index.html来撤消index.html的修改。

$ git checkout -- index.html    # 撤消index.html单个文件
$ git chekcout -- .             # 撤消所有修改的文件

注意：一定要加--，不加就是切换分支了。

撤消暂存区的修改（已经执行git add，但未执行git commit）
======================================================

如果不幸通过git add提交到了暂存区，则需要通过git reset来撤消。

$ git reset HEAD index.html     # 撤消index.html单个文件
$ git reset HEAD .              # 撤消所有的文件

注意：这里只是撤消暂存区的修改，所以工作目录看上去是没有任何变化的。

撤消本地仓库中的修改（已经执行git commit，但未执行git push）
===========================================================

查看下提交记录。

git log --oneline

6869000 git reset --hard id
242f6ab 引入reset.css样式文件
907996a git add后使用git reset HEAD filename撤销修改
2ebc649 撤销工作区的修改，直接使用git checkout -- filename（还没git add）
cdbda2d 修改title为move-tack
13e4cb9 first commit


$ git reset --hard HEAD^        # 退回到上一次提交
$ git reset --hard 242f6ab      # 通过commitId来回退到指定版本


git reset --mixed(默认，相当于git reset)
----------------------------------------

回退到指定版本，工作区的内容会保留，暂存区会回退，比如在上一次commit后，新增了a.html文件并add到暂存区，同时修改了b.html文件，没有add提交，那么在使用git reset后，工作区的内容会保留，在b.html文件中做的修改还存在，但是暂存区的内容不会保留，如果需要再提交，需要重新执行git add a.html将a.html添加到暂存区，再执行git commit

git reset --hard
----------------

强制回退到指定版，工作区和暂存区的内容会被重置(有风险，工作区和暂存区的修改都不会保留)，比如在上一次commit后，新增了a.html文件并且git add到暂存区，同时修改了b.html文件，没有add提交，那么在使用git reset --hard后，暂存区中的a.html文件和工作区的b.html文件都会被清除。

git reset --soft
----------------

回退到指定版本，工作区和暂存区的内容会被保留。比如在上一次commit后，新增了a.html文件并且add到暂存区，同时修改了b.html文件，没有add提交，那么在使用git reset --soft后，暂存区和工作区的内容还在，工作区对b.html文件的修改会保留，同时a.html也在暂存区中，如果需要再提交，直接git commmit就行

撤消远程仓库的修改（已经执行git push）
=====================================

使用git reset回滚时直接删除指定版本后的提交记录，使用git log看不到后面的记录（如果需要看到回滚前的版本，可以使用git reflog）。

git revert是用一次新的commit来回滚之前的commit，之前的提交记录都会保留。

使用git revert进行回滚，有个问题就是，如果在回滚前通过git push推送到了远程仓库，那远程仓库的版本就比本地仓库的版本要新，回滚后想好再次推送到远程仓库，肯定会报错，提示要行git pull，但是，如果你git pull了，那之前的回滚操作就白做了。

这时候，如果通过git push -f -u origin master强推去覆盖远程仓库，在多从协作的时候，如果别个正好pull了远程仓库最新的代码来开发，下次别人再pull的时候，他本地的git怎么处理已经被删除的提交？当别人使用git push正常推到远程仓库时，也会提示本地仓库落后于远程仓库，会引起更多的问题，所以这时候就需要使用git revert来回滚了。

执行git revert时，必须确保工作区是clean状态

$ git revert HEAD       # 撤消最近一次提交
$ git revert HEAD~1     # 撤消上上次提交（数字从0开始）
$ git revert commidID   # 撤消指定的某一次提交

注意： 如果不是撤消最近的一次提交，一定会造成冲突，需要解决完冲突后再提交。

使用远程仓库覆盖本地仓库
========================

$ git reset --hard origin/master    # 使用远程的master分支直接覆盖本地的master分支


查看当前详细的提交信息
======================

$ git log

查看当前操作信息（主要可以查看对应版本的ID）
===========================================

$ git reflog

回到指定的版本
==============

$ git reset --hard 版本号


git重置或还原已提交的代码
=========================

HEAD是当前分支引用的指针，它总是指向该分支上的最后一次提交，这表示HEAD将是下一次提交的父节点。


#. git reset 就是修改HEAD的位置，即将HEAD指向的位置改变为之前存在的某个版本。

$ git reset HEAD --file         # 回退暂存区里的某个文件，回退到当前版本工作区状态
$ git reset --soft 目标版本号   # 可以把版本库上的提交回退到暂存区，修改记录保留
$ git reset --mixed 目标版本号  # 可以反版本库上的提交退回到工作区，修改记录保留
# git reset --hard              # 可以把版本库上的提交彻底回退，修改的记录全部revert

适用场景：

如果我们想直接回到之前的某一版本，但是不想保留该目标版本后面的版本，就可以使用该方法。

#. git revert

适用场景：

如果我们想撤消之前的某一个版本，但又想保留该目标版本后面的版本，记录下这整个版本变动流程，就可以使用该方法。


git的工作区、暂存区、版本库
===========================

#. 工作区：就是在电脑里能看到的目录。
#. 暂存区：英文叫stage或index，一般存放在.git目录下的index文件中，所以我们把暂存区叫作索引（index）。
#. 版本库：工作区有个隐藏的目录。这个不算工作区，而是Git的版本库。

在Docker容器中运行Jenkins
=========================

docker run                                   \
    -p 8080:8080                             \
    -p 50000:5000                            \
    --name jenkins                           \
    -u root                                  \
    -v ${PWD}/jenkins_home:/var/jenkins_home \
    -d jenkins/jenkins:lts

使用管理员密码进行登录，可以使用以下命令从容器启动日志中获取管理密码：
docker logs jenkins

