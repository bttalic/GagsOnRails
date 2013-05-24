$(document).ready(function(){

	if($(' #micropostcontent').length>0)	{
console.log($(' #micropostcontent').length);
$.each($(' #micropostcontent'), function(i, result){
	console.log(result);
		var micropostHTML=$(result).html();
console.log(micropostHTML);
		//micropostHTML=micropostHTML.replace(/^@(\w+)/g, "<b>link</b>");

		var words=micropostHTML.split(' ');

		$.each(words,function(i,word){
			if(word.indexOf('#')>=0){
				console.log(word);
				var newWord=word.substring(1,word.length);
				newWord="<a href=\"/search?term="+newWord+"\">"+word+"</a>";
				micropostHTML=micropostHTML.replace(word,newWord);
			}
		});


		$(result).html(micropostHTML);
	});
}
});