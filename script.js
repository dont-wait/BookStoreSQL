let csvToJson = require('convert-csv-to-json');

let json = csvToJson.getJsonFromCsv("books_dataset.csv", {maxRows: 10});
for(let i=0; i<json.length;i++){
    console.log(json[i]);
}