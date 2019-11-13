| Name | Description | Data type | Value constraints | Example(s) |
|:--|:--|:--|:--|:--|
| dataset | Concise description of dataset | string | No reference to measure | Senior salaries | 
| period | The period of time the data refer to | String | Date: YYYY-MM or YYYY-MM-DD |  2019-01 or 2018-12-31 |
| |  | | Single year: YYYY | 2019 |
| |  | | Financial/education year: YYYY/YY | 2017/18 | 
| |  | | Date range: YYYY to YYYY | 2016 to 2019 |
| address | Full address excluding postcode | string | Full address separated by commas | Trafford Council, Trafford Town Hall, Talbot Road, Stretford |
| postcode | Valid postcode | string | Between 5 and 7 alphanumeric characters in UPPERCASE. Check validity with [http://www.royalmail.com/postcode-finder](http://www.royalmail.com/postcode-finder) | M32 0TH |
| lon | Longitude  | Double | 5 or 6 decimal places | 53.458696 |
| lat | Latitude  | Double | 5 or 6 decimal places | -2.287366 |
| measure | How values are expressed | String | Maintain consistency of terms | Count, Percentage, Rate, Median, Ratio |
| unit | The unit of measurement | String | Maintain consistency of terms | Households, Persons, Crimes |
| value | A numeric value  | Integer / Double |  Round value to one decimal digit | 3.4 |