class CalculatorController < ApplicationController
  def main
  end

  def calculate
    # store original input
    @original_str = params['equation']
    # remove extra spaces
    stripped_str = params['equation'].to_s.strip.gsub(/\s+/,'')

    if CalculationService.validate_input(stripped_str)
      @final_str = CalculationService.calculate(stripped_str)
    else
      @final_str = 'Invalid input'
    end

    respond_to do |format|
      format.js
    end
  end
end
