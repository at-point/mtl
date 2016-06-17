module DomSupport
  extend RSpec::Matchers::DSL

  def stupid_normalize_dom(str)
    str.to_s.strip.gsub(/\s+/, '') # simply remove *any* whitespace
  end

  matcher :match_dom do |expected|
    match { |actual| stupid_normalize_dom(actual) == stupid_normalize_dom(expected) }
  end

  matcher :contain_dom do |expected|
    match { |actual| stupid_normalize_dom(actual).include?(stupid_normalize_dom(expected)) }
  end
end
