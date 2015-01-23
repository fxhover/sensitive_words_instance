# -*- coding: utf-8 -*-
$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'sensitive_words'

#首先载入敏感词词典
sw = SensitiveWords.new
sw.load_dict("#{File.dirname(__FILE__)}/dictionary/dict1.txt")
sw.load_dict("#{File.dirname(__FILE__)}/dictionary/dict2.txt")

#从数组加载敏感词词典
sw.add_dict_from_arr %w(习近平 周永康 暴干 BLOWJOB 流氓政府 FUCKYOU FUCK 你大爷)

article = "习近平周永暴干康BLOWJOBjeffrey哈哈哈流氓政府"

#找出文章中的所有敏感词
words = sw.match(article)
puts words.inspect   # => ["习近平", "暴干", "BLOWJOB", "流氓政府"]

#或者只需要指定数量上限的敏感词
words = sw.match(article,2)
puts words.inspect   # => ["习近平", "暴干"]


