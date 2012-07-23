# encoding: utf-8
module DealsHelper
  def currency_to_symbol(abbreviation)
    case abbreviation
    when "RUR" then '<span class="rur">p<span>уб.</span></span>'.html_safe
    when "USD" then "$"
    else abbreviation
    end
  end
end
