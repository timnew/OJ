class EndOfString
  def search_node(pattern, index)
    index == pattern.length + 1
  end
end

class TrieNode
  EOS = EndOfString.new

  attr_reader :children

  def initialize
    @children = {}
  end

  def [](char)
    children[char]
  end

  def add_node(word, index)
    char = word[index]

    return mark_eos if char.nil?

    child = children[char]

    child = children[char] = TrieNode.new if child.nil?

    child.add_node(word, index + 1)
  end

  def mark_eos
    children[nil] = EOS
  end

  def search_node(pattern, index)
    char = pattern[index]

    if char == '.'
      children.values.any? { |next_node| next_node.search_node(pattern, index + 1) }
    else
      next_node = self[char]

      return false if next_node.nil?

      next_node.search_node(pattern, index + 1)
    end
  end
end

class WordDictionary < TrieNode
  # @param {string} word
  # @return {void}
  # Adds a word into the data structure.
  def add_word(word)
    add_node(word, 0)
  end

  # @param {string} word
  # @return {boolean}
  # Returns if the word is in the data structure. A word could
  # contain the dot character '.' to represent any one letter.
  def search(word)
    search_node(word, 0)
  end
end
