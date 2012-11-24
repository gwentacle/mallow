Mallow::Test.cases {
  def DocTest1; 4 + 5 end
  def DocTest2; 'test'.upcase end
  def DocTest3; 1/0  end
  def DocExample
    Mallow.test { |that|
      that.DocTest1.returns_a(Fixnum).such_that {self < 100}
      that.DocTest2.returns 'TeST'
      that.DocTest3.returns_a Numeric
    }
  end
}

Mallow.test(true) {|that|
  that.DocExample.returns_an(Array).of_size(3).such_that {
    at(0)    == [:DocTest1, true ] and
    at(1)    == [:DocTest2, false] and
    at(2)[0] ==  :DocTest3         and
    at(2)[1].is_a? ZeroDivisionError
  }
}
