# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    lines = tsv.split("\n")
    @data = hash_keys_values(lines)
  rescue StandardError => error
    puts error.message
  end

  def data_keys(lines)
    lines[0].split("\t")
  end

  def data_values(lines)
    lines[1..-1].map { |x| x.split "\t" }
  end

  def hash_keys_values(lines)
    data_values(lines).map { |value| Hash[data_keys(lines).zip(value)] }
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    join_headers_rows(@data)
  end

  def tsv_headers(data)
    data[0].keys
  end

  def tsv_rows(data)
    data.map { |x| x.values.reduce { |i, j| "#{i}\t#{j}" } }
  end

  def join_headers_rows(data)
    tsv_headers(data).join("\t") + "\n" + tsv_rows(data).join("\n") + "\n"
  end

end
