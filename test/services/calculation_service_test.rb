require 'test_helper'

class CalculationServiceTest <  ActiveSupport::TestCase
  test "should be able to validate single digit" do
    assert(CalculationService.validate_input('1'))
  end

  test "should be able to validate single negative digit" do
    assert(CalculationService.validate_input('-1'))
  end

  test "should be able to validate same operand" do
    assert(CalculationService.validate_input('1*2*3*4*5'))
  end

  test "should be able to validate negative number calculations" do
    assert(CalculationService.validate_input('1*2*-3*4*5'))
  end

  test "should be able to validate example input 1" do
    assert(CalculationService.validate_input('5*3+1+6/2+9*100'))
  end

  test "should be able to validate example input 2" do
    assert(CalculationService.validate_input('5*3+1+6/85+9*100'))
  end

  test "should be able to fail validation on letters" do
    assert(!CalculationService.validate_input('ab'))
  end

  test "should be able to fail validation on empty" do
    assert(!CalculationService.validate_input(''))
  end

  test "should be able to fail validation with extra operands" do
    assert(!CalculationService.validate_input('-1---4'))
  end

  test "should be able to calculate single negative digit" do
    assert_equal(-1, CalculationService.calculate('-1'))
  end

  test "should be able to calculate negative number calculations" do
    assert_equal(-120, CalculationService.calculate('1*2*-3*4*5'))
  end

  test "should be able to calculate same operand 1" do
    assert_equal(5, CalculationService.calculate('3--3-1'))
  end

  test "should be able to calculate same operand 2" do
    assert_equal(120, CalculationService.calculate('1*2*3*4*5'))
  end

  test "should be able to calculate example input 1" do
    assert_equal(919, CalculationService.calculate('5*3+1+6/2+9*100'))
  end

  test "should be able to calculate example input 2" do
    assert_equal(916.07, CalculationService.calculate('5*3+1+6/85+9*100'))
  end
end
