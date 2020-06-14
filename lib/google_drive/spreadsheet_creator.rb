require 'google_drive'

module GoogleDrive
  class SpreadsheetCreator
    def self.create_spreadsheet(spreadsheet_key, sheet_name)
      # SEE: https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
      service = GoogleDrive::Session.from_service_account_key(ENV['JSON_KEY_PATH'])
      ws = service.spreadsheet_by_key(spreadsheet_key)
      ws.worksheet_by_title(sheet_name) || ws.add_worksheet(sheet_name)
    end
  end
end
