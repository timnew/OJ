require 'word_dictionary'

describe WordDictionary do
  subject { WordDictionary.new }

  it 'should find single letter' do
    subject.add_word 'e'
    expect(subject.search('e')).to be true
  end

  it 'should find inexist letter' do
    subject.add_word 'e'
    expect(subject.search('f')).to be false
  end

  it 'should find single word' do
    subject.add_word 'ab'
    expect(subject.search('ab')).to be true
  end

  it 'should find inexist single word' do
    subject.add_word 'ab'
    expect(subject.search('ac')).to be false
  end

  it 'should find multiple words' do
    subject.add_word 'ab'
    subject.add_word 'ad'
    subject.add_word 'ed'
    subject.add_word 'ade'

    expect(subject.search('ad')).to be true
  end

  it 'should find inexist word in multiple words' do
    subject.add_word 'ab'
    subject.add_word 'ad'
    subject.add_word 'ed'
    subject.add_word 'ade'

    expect(subject.search('af')).to be false
  end

  it 'should recognize EOS' do
    subject.add_word 'ade'

    expect(subject.search('ad')).to be false

    expect(subject.search('adee')).to be false
  end

  it 'should handle single .' do
    subject.add_word 'e'
    expect(subject.search('.')).to be true
  end

  it 'should match .x pattern' do
    subject.add_word 'ab'
    expect(subject.search('.b')).to be true
    expect(subject.search('.c')).to be false
  end

  it 'should match x. pattern' do
    subject.add_word 'ab'
    expect(subject.search('a.')).to be true
    expect(subject.search('b.')).to be false
  end

  it 'should match x.x pattern' do
    subject.add_word 'abd'
    subject.add_word 'abc'
    expect(subject.search('a.c')).to be true
    expect(subject.search('a.x')).to be false
    expect(subject.search('x.c')).to be false
  end

  it 'should handle .xx pattern' do
    subject.add_word 'abd'
    subject.add_word 'abc'
    expect(subject.search('a.c')).to be true
    expect(subject.search('a.x')).to be false
    expect(subject.search('x.c')).to be false
  end
end
