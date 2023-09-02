=========
Hello Git
=========


Git添加多个远程仓库
===================

查看有多少个仓库
++++++++++++++++

git remote -v

添加github远程仓库
++++++++++++++++++

git remote add github https://github.com/lynyujiang/doclikecode.git
git push -u github master

添加gitee远程仓库
+++++++++++++++++

git remote add gitee https://gitee.com/lynyujiang/doclikecode.git
git push -u gitee master

从两个仓库拉取代码
++++++++++++++++++

git pull

推送代码到两个仓库
++++++++++++++++++

git push --all

推送代码到github仓库
++++++++++++++++++++

git push github master

推送代码到gitee仓库
++++++++++++++++++++

git push gitee master

git重新提交
===========

git reset --soft HEAD~n ,撤销最近n个提交，变成add状态，可以重新commit
git push -f 强制推送到远程

git回滚
=======

git reset --hard HEAD~n ,回滚最近n个提交，代码彻底删除了，找不回来
git push -f 强制推送到远程

git 删除某个提交
================

git reset --soft HEAD~n ,撤销最近n个提交，变成add状态
git stash 暂存代码
git reset --hard HEAD~1 删除前1一个提交
git unstash 取出代码
git commit 重新提交代码
git push -f 强制推送到远程
