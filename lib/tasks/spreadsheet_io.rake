require 'lib/google_drive/spreadsheet_creator'
require 'lib/google_drive/spreadsheet'

namespace :spreadsheet_io do
  desc 'Export from google spreadsheet'
  task :export, ['sheet_id', 'sheet_name'] do |_task, args|
    begin
      sheet_id = args[:sheet_id]
      sheet_name = args[:sheet_name]
      spreadsheet = GoogleDrive::SpreadsheetCreator.create_spreadsheet(sheet_id, sheet_name)
      spreadsheet_records = GoogleDrive::Spreadsheet.do_export(spreadsheet)
      pp spreadsheet_records
    rescue StandardError => e
      raise e
    end
  end

  desc 'Import from google spreadsheet'
  task :import, ['sheet_id', 'sheet_name'] do |_task, args|
    begin
      sheet_id = args[:sheet_id]
      sheet_name = args[:sheet_name]
      import_records = []
      spreadsheets = GoogleDrive::SpreadsheetCreator.create_spreadsheet(sheet_id, sheet_name)
      GoogleDrive::Spreadsheet.do_import(spreadsheets, import_records)
    rescue StandardError => e
      raise e
    end
  end
end
