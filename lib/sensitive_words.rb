# -*- coding: utf-8 -*-

class SensitiveWords

  def initialize
    @dict = {}
    @words = []
  end

  #从文件加载字典
  def load_dict(dict_path)
    new_dict = get_dict_file_hash(dict_path)
    dict = @dict.merge new_dict
    @dict = dict
  rescue Errno::ENOENT => boom
    puts "#{boom.class} - #{boom.message}"
  end

  #从数组加载字典
  def add_dict_from_arr(dict_arr = [])
    new_dict = get_dict_arr_hash(dict_arr)
    dict = @dict.merge new_dict
    @dict = dict
  rescue Errno::ENOENT => boom
    puts "#{boom.class} - #{boom.message}"
  end

  #清除字典
  def clear_dict
    @dict.clear
  end

  def match(input, max=nil)
    @input = input
    max = max.to_i
    if max > 0
      sensitive_words(max)
    else
      all_sensitive_words
    end
  end

  private

  def get_dict_arr_hash(dict_arr)
    tree = {}
    dict_arr.each do |word|
      word = word.chomp
      next if word.empty?
      node = nil
      word.chars.each do |c|
        if node
          node[c] ||= {}
          node = node[c]
        else
          tree[c] ||= {}
          node = tree[c]
        end
      end
      node[:end] = :id
    end
    tree
  end

  def get_dict_file_hash(path)
    tree = {}
    file = File.open(path, 'r')
    if file
      file.each_line do |line|
        line = line.chomp
        next if line.empty?
        node = nil
        line.chars.each do |c|
          if node
            node[c] ||= {}
            node = node[c]
          else
            tree[c] ||= {}
            node = tree[c]
          end
        end
        node[:end] = :id
      end
    end
    tree
  ensure
    file.close if file
  end

  #只要有限个敏感词
  def sensitive_words(max)
    @node, @words = @dict, []
    @word, @queue = '', []

    @input.chars.each do |char|
      break if @words.size >= max
      loop do
        break if @queue.empty?
        chr = @queue.shift
        process_check(chr, true)
      end
      process_check(char)
    end

    process_check('')
    @words.first(max)
  end

  #所有的敏感词
  def all_sensitive_words
    @node, @words = @dict, []
    @word, @queue = '', []

    @input.chars.each do |char|
      loop do
        break if @queue.empty?
        chr = @queue.shift
        process_check(chr, true)
      end
      process_check(char)
    end

    process_check('')
    @words
  end

  def process_check(char,queuing=false)

    match, word = nil, nil

    if @node[char]
      @word << char
      @node = @node[char]
      match = :id
    else
      if @node[:end]
        word = @word
      end
      lth = @word.length
      if lth > 0
        if queuing
          @queue.unshift char
        else
          if lth > 1
            @queue += @word.chars.to_a.last(lth-1)
          end
          @queue << char
        end
      end

      @node = @dict
      @word = ''
    end

    if !match && word
      @words << word
    end
  end
  
end
