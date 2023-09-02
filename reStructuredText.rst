================
reStructuredText
================

:标题: reStructuredText语法说明

:作者:
 - 作者A
 - 作者B

:时间: 2023年1月26日

:概述: 这是第一篇
 关于reStructuredText

 语法说明。


在本地预览文档
==============

方法一：

进入到生成的 build/html 目录下，运行 python3 -m http.server 8000 指令，然后在浏览器中打开 http://localhost:8000 即可查看生成的静态网页。

方法二

进入到生成的 build/html 目录下，运行 xdg-open index.html 指令即可查看生成的静态网页。

允许其它主机访问自己的文档
==========================

进入到生成的 build/html 目录下，运行 python3 -m http.server --bind 0.0.0.0 8000 指令，然后在浏览器中打开 http://你的主机IP地址:8000 即可查看生成的静态网页。

段落
====

段落(ref)是reST文档中最基本的块。段落是由一个或多个空白行分离的简单文本块。在Python中，缩进在reST中是具有重要意义，所以同一段落的所有行必须左对齐而且是同一级缩进。

缩进的段落被视为引文。


行内标记
========

单星号： *text* 强调（斜体）

双星号： **text** 重点强调（粗体）

反引号： ``text`` 代码示例（等宽）

注意行内标记的一些限制：

* 不能嵌套
* 文本不能以空格开始或者结束： * text*是不正确的
* 必须由空格从周围文本分离出来

超链接
======

这是 `Sphinx 使用手册 <https://zh-sphinx-doc.readthedocs.io/en/latest/contents.html>`_

这是reStructuredText入门: http://www.pythondoc.com/sphinx/rest.html

列表和“类”引用块
================

列表标记(ref) 是自然的：只要在段落开头放置一个星号和缩进正常。带编号的列表同样适用；它们也可以自动编号通过使用标志 #:

* This is a bulleted list.
* It has two items, the second
  item uses two lines.

1. This is a numbered list.
2. It has two items too.

#. This is a numbered list.
#. It has two items too.

嵌套列表是可能的，但要知道，它们必须由空行从父列表中分隔:

* this is
* a list

  * with a nested list
  * and some subitems

* and here the parent list continues

定义列表 (ref) 的创建:

term (up to a line of text)
   Definition of the term, which must be indented

   and can even consist of multiple paragraphs

next term
   Description.

请注意，term 不能有一个以上的文本行。

引用段落(ref) 可以通过比周围的段落更缩进来创建。

行块元素 (ref) 是防止行被破坏的方式（保留行原样的方式）:

| These lines are
| broken exactly like in
| the source file.


文字块
======

文字块就是一段文字信息，在需要插入文本块的段落后面加上::，接着一个空行，然后就是文字块了。



源代码
======

这是一段正常文本。下一段是代码文字：

::

    它不需要特别处理，仅是
    缩进就可以了。

    它可以有多行。

再是正常的文本段。


文字代码块(ref)是在段尾加入特殊标记 :: 引入的。文字代码块必须缩进（像所有的段落，是通过空行来分离的）:

This is a normal text paragraph. The next paragraph is a code sample::

   It is not processed in any way, except
   that the indentation is removed.

   It can span multiple lines.

This is a normal text paragraph again.

:: 标记的处理非常聪明:

    如果出现在段落本身中，那么整个段落将会从文档中删除（也就是说不会出现在生成的文档中）。
    如果它前面的空白，标记将被删除。
    如果它的前面非空白，标记会被单个冒号取代。

通过这种方式，上面第二句将呈现为 “The next paragraph is a code sample:”。


文本代码
========

.. code::

    这是一段引用的文本，文字将显示在一个方格框里面


表格
====

Sphinx支持两种表格形式。对于 格子表格 (ref)，必须自己“画”自己的单元格。它们看起来像这样:

+------------------------+------------+----------+----------+
| Header row, column 1   | Header 2   | Header 3 | Header 4 |
| (header rows optional) |            |          |          |
+========================+============+==========+==========+
| body row 1, column 1   | column 2   | column 3 | column 4 |
+------------------------+------------+----------+----------+
| body row 2             | ...        | ...      |          |
+------------------------+------------+----------+----------+

简单表格 (ref) 更容易书写，但是有限制：表格必须是两行以及以上，而且第一列不能包含多行。它们看起来像这样:

=====  =====  =======
A      B      A and B
=====  =====  =======
False  False  False
True   False  False
False  True   False
True   True   True
=====  =====  =======



评论
====

不是一个有效的标记结构（如上述的脚注）的每一个明确的标记块被视为一条评论（ref）。例如:

.. This is a comment.

您可以缩进文本在注释开始后，这样可以形成多行注释:

..
   This whole indented block
   is a comment.

   Still in the comment.


@startuml
Bob -> Alice : Hello, how are you
Alice -> Bob : Fine, thank you, and you?
