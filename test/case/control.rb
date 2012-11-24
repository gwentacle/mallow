Mallow::Test.cases {
  def NinetyNine; 99 end
  def NameError; raise Asdf.qwer.ty / 0 end
}

Mallow.test(true) {|that|
  that.NinetyNine.returns_a(Fixnum).such_that {self==99}.and_that_is 99
  that.NameError.raises.and_raises_a NameError
}
