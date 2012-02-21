class String
  def sql_escape_single_quotes
    self.gsub(/[']/, "''")
  end
end