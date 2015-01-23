# sensitive_words

检索文章中的敏感词


### Install
```sh
$ git clone git@github.com:fxhover/sensitive_words_instance.git
$ cd sensitive_words
$ gem install sensitive_words-0.0.1.gem
```

###Install in Rails
gem 'sensitive_words', git: 'https://github.com/fxhover/sensitive_words_instance.git'

### Test code

``` ruby
# -*- coding: utf-8 -*-

require 'sensitive_words'

sw = SensitiveWords.new
#首先载入敏感词文件
sw.load_dict("#{__dir__}/dictionary/dict1.txt")
sw.load_dict("#{__dir__}/dictionary/dict2.txt") #可以载入多次

#也可以从ruby数组载入敏感词
sw.add_dict_from_arr %w(习近平 周永康 暴干 BLOWJOB 流氓政府 FUCKYOU FUCK 你大爷)

article = "习近平周永暴干康BLOWJOBjeffrey哈哈哈流氓政府"

#找出文章中的所有敏感词
words = sw.match(article)
puts words.inspect   # => ["习近平", "暴干", "BLOWJOB", "流氓政府"]

#或者只需要指定数量上限的敏感词
words = sw.match(article,2)
puts words.inspect   # => ["习近平", "暴干"]

#清除敏感词字典
sw.clear_dict
```

### 敏感词文件示例

说明： 纯文本，一行一个

``` plain
习近平
周永康
暴干
BLOWJOB
流氓政府

```


yeah.happy coding:)




