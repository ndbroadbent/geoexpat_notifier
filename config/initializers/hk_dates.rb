# Parse HK dates
Date.instance_eval do
  def parse_hk(string)
    strptime(string, "%d/%m/%Y")
  end
end

