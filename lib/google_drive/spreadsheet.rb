module GoogleDrive
  class Spreadsheet
    def self.do_import(spreadsheets, worksheets)
      spreadsheet = spreadsheets[1]
      timeout(90) do
        worksheets.each do |_, records|
          next if records.blank?

          spreadsheet.update_cells(1, 1, [records[0].keys])
          records.each do |record|
            spreadsheet.list.push(record)
          end
        end
        spreadsheet.save
      end
    end

    def self.do_export(spreadsheets)
      worksheets = {}
      records = []
      record_num = 0
      spreadsheets.each do |spreadsheet|
        records = []
        record_num = 0
        rows = 2..spreadsheet.num_rows # exclude first record for header information
        cols = 1..spreadsheet.num_cols
        rows.each do |num_row|
          record = cols.map { |num_col| [spreadsheet[1, num_col], format_column(spreadsheet[num_row, num_col])] }.to_h
          record = merge_record(record)
          records[record_num] = record
          record_num += 1
        end
        worksheets[spreadsheet.title] = records
      end
      worksheets
    end

    def self.format_column(column)
      NKF.nkf('-m0Z1 -w', column).gsub(/(\r\n|\r|\n)/, ' ').gsub(/\s+/, "\n")
    end

    def self.merge_record(record)
      {
        merge_sample: 'hogehoge'
      }.merge(record)
    end
  end
end
