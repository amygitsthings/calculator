module CalculationService
  extend self

  # performs math calculation on input_str
  # returns float
  def calculate (input_str)
    input_ary = split_string(input_str)

    ORDER_OF_OPERANDS.each do |operands|
      input_ary = perform_calculations(input_ary, operands)
      # break out if we've already calculated final number
      break if input_ary.size == 1
    end
    input_ary.first.to_f.round(2)
  end

  # returns true if input_str is valid format (<number><operand>..<number>)
  def validate_input (input_str)
    input_str =~ VALIDATION_REGEX
  end

  private

  # string must be of form <number><operand><number>
  VALIDATION_REGEX = /^(\-?\d+)([\+\-\*\/]-?\d+)*$/.freeze
  # split up string on number and operand
  SCAN_REGEX = /(\-?\d+)|([\+\-\*\/])/.freeze
  ORDER_OF_OPERANDS = [['*','/'], ['+','-']].freeze

  def perform_calculations (input_ary, calculate_operands)
    leftover_ary = []
    left = nil
    operand = nil
    input_ary.each do |x|
      if left.nil?
        left = x
      elsif operand.nil?
        operand = x
      elsif calculate_operands.include?(operand)
        left = send(operand, left, x)
        operand = nil
      else
        leftover_ary << left << operand
        left = x
        operand = nil
      end
    end
    leftover_ary << left
    leftover_ary
  end

  # split str on each number and operand and push into an array
  def split_string(input_str)
    input_ary = []
    input_str.scan(SCAN_REGEX) do |current|
      # special logic to tell the difference between negative number and minus operand
      if current.compact.first.match(/\-(\d+)/) && input_ary.size.odd?
        input_ary << '-' << Regexp.last_match(1)
      else
        input_ary << current.compact.first
      end
    end
    input_ary
  end

  def + (left, right)
    left.to_f + right.to_f
  end

  def - (left, right)
    left.to_f - right.to_f
  end

  def * (left, right)
    left.to_f * right.to_f
  end

  def / (left, right)
    left.to_f / right.to_f
  end
end
