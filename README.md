## Council open data

Datasets that [Trafford Council](https://www.trafford.gov.uk) create and publish, i.e. the council is the source as well as the publisher of the data. Included within this repository is a [transparency_code](https://github.com/traffordDataLab/council_open_data/tree/master/transparency_code) sub-folder, containing those datasets required to be published in order to meet the minimum requirements of the [Local Government Transparency Code 2015](https://www.gov.uk/government/publications/local-government-transparency-code-2015).

The datasets are usually published on the [open data page](https://www.trafford.gov.uk/about-your-council/data-protection/open-data) (or sub-pages) of the Trafford Council website. They are then cleaned and structured as necessary according to our [common standard](schema.md) and stored within this repository. An entry for the datasets are created on [data.gov.uk](https://data.gov.uk/search?filters%5Bpublisher%5D=Trafford+Council) pointing to this repository, not the council website.

All datasets are available under an [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/) and where possible have a [3 star open data rating](https://5stardata.info/en/) because they are in a non-proprietary open format (e.g. CSV or GeoJSON).

For datasets regarding Trafford which are published by an external source, but cleaned and tidied by Trafford Data Lab, please see our [open_data repository](https://github.com/traffordDataLab/open_data).

### Workflow

1. Create a folder in the [council_open_data](https://github.com/traffordDataLab/council_open_data) repository with the name of the dataset in [snake case](https://en.wikipedia.org/wiki/Snake_case), e.g. `senior_salaries`.
2. Add a README.md containing dataset [metadata](metadata.md).
3. Clean and structure the dataset to a [common standard](schema.md). Keep any R scripts in the folder for re-use.
4. Save the dataset in an open non-proprietary format (e.g. CSV, GeoJSON) with the same name as the folder and if necessary suffix with a date, e.g. `senior_salaries_2018-19.csv`
5. Create a [JSON file](-metadata.json) containing information about the dataset's variables. Following [W3C guidance](https://www.w3.org/TR/tabular-data-primer/#metadata) call the metadata file `[dataset_name].[file format]-metadata.json`, e.g. `senior_salaries.csv-metadata.json`. The date suffix is not necessary as the variable names will be the same across releases.
6. Publish the dataset and accompanying JSON metadata on [data.gov.uk](https://data.gov.uk/search?filters%5Bpublisher%5D=Trafford+Council). Please use the GitHub Pages URL e.g. `https://www.trafforddatalab.io/council_open_data/...` rather than `https://raw.githubusercontent.com/traffordDataLab/council_open_data/...`.
