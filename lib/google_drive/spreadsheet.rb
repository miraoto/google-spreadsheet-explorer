module GoogleDrive
  class Spreadsheet
    def self.do_import(spreadsheet, records)
      Timeout.timeout(ENV['IMPORT_TIMEOUT'] || 90) do
        records.each.with_index(1) do |record, i|
          record.each.with_index(1) do |(_k, v), j|
            spreadsheet[i, j] = v
          end
        end
        spreadsheet.save
      end
    end

    def self.do_export(spreadsheet)
      records = []
      record_line = 0
      rows = 2..spreadsheet.num_rows # exclude first record for header information
      cols = 1..spreadsheet.num_cols
      rows.each do |num_row|
        records[record_line] = cols.map { |num_col| [spreadsheet[1, num_col], format_column(spreadsheet[num_row, num_col])] }.to_h
        record_line += 1
      end
      records
    end

    def self.format_column(column)
      NKF.nkf('-m0Z1 -w', column).gsub(/(\r\n|\r|\n)/, ' ').gsub(/\s+/, "\n")
    end
  end
end
