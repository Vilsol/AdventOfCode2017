fs = require('fs');

function isValid(phrase) {
	const words = phrase.split(" ")
	const used = []

	for (var z = words.length - 1; z >= 0; z--) {
		if(used.indexOf(words[z]) >= 0){
			break;
		}
		used.push(words[z])
	}

	return used.length == words.length
}

fs.readFile("input.txt", "utf8", function (error, data) {
	let valid = 0
	const phrases = data.split("\n")
	for (var i = phrases.length - 1; i >= 0; i--) {
		if(isValid(phrases[i].trim())){
			valid++
		}
	}

	console.log(valid)
});