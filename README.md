# google-spreadsheet-explorer

I/O google spreadsheet using "Google Drive API" and "Google Sheets API".

## Prepare

- Prepare [google-drive-ruby authorization json file](https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md) and placement under the document root.
- Setup .env


## Usage

### Import

```ruby
bundle exec rake spreadsheet_io:import[SHEET_ID,SHEET_NAME]
```

### Export

```ruby
bundle exec rake spreadsheet_io:export[SHEET_ID,SHEET_NAME]
```
