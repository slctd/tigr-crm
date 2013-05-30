class Hash
  def stringify_values
    inject({}) do |options, (key, value)|
      options[key] = value.to_s
      options
    end
  end
end