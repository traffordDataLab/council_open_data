## Council open data

Datasets that [Trafford Council](https://www.trafford.gov.uk) are required to publish to meet the minimum requirements of the [Local Government Transparency Code](https://www.gov.uk/government/publications/local-government-transparency-code-2015) are stored in this repository. 

Visitors to Trafford Council's [open data page](https://www.trafford.gov.uk/about-your-council/data-protection/open-data/open-data.aspx) will be directed to the corresponding [data.gov.uk](https://data.gov.uk/search?filters%5Bpublisher%5D=Trafford+Council) page which provides metadata for each dataset and a direct download link.

All datasets have a [3 star open data rating](https://5stardata.info/en/) because they are available under an [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/) in a non-proprietary open format (e.g. CSV or GeoJSON).

Each dataset is structured and follows a common standard or schema:

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

Each dataset is stored in its own folder with a README.md containing metadata:

<table>
<tr>
	<td>Dataset</td>
	<td></td>
</tr>
<tr>
	<td>Description</td>
	<td></td>
</tr>
<tr>
	<td>Frequency</td>
	<td></td>
</tr>
<tr>
	<td>Licence</td>
	<td><a href="http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/">OGL v3.0</a></td>
</tr>
<tr>
	<td>Format</td>
	<td></td>
</tr>
<tr>
	<td>Openness rating</td>
	<td>&#9733&#9733&#9733&#9734&#9734&nbsp; Structured data in a non-proprietary format (e.g. CSV)</td>
</tr>
<tr>
	<td>Last updated</td>
	<td></td>
</tr>
</table>



