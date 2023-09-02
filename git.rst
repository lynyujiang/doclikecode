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
