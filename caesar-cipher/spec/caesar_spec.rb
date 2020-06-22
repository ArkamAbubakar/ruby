#spec/caesar_spec.rb
require './lib/caesar'

describe "#caesar" do
  it "works with single words" do
    expect(caesar_cipher("fart", 5)).to eql("kfwy")
  end

  it "works with multiple words" do
    expect(caesar_cipher("fart man", 7)).to eql("mhya thu")
  end

  it "wraps around from the end to the beginning" do
    expect(caesar_cipher("fart boy", 10)).to eql("pkbd lyi")
  end

  it "keeps capitalization" do
    expect(caesar_cipher("cApItAlizAtioN", 3)).to eql("fDsLwDolcDwlrQ")
  end

  it "ignores punctuation" do
    expect(caesar_cipher("Hello, World!", 15)).to eql("Wtaad, Ldgas!")
  end
end