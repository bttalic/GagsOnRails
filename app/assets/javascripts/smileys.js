$(document).ready(function () {

if($("#comments").length>0){
	var html=$("#comments").html();


	var smiles=[ ":)", ":(", ":D", ":p", ":P", ":/", ":*", ":@", ";)", ":o", ":O" , ":hrt" ];
	var smileLinks=['smile1', 'smile2', 'smile3', 'smile4', 'smile4', 'smile5', 'smile6', 'smile7', 'smile8', 'smile9', 'smile9', 'smile10'];

	for(var i=0; i<smiles.length; i++){
		var image="<img src=\"/assets/"+smileLinks[i]+".png\" style='width:20px; height:20px' />";
		var search=" "+smiles[i];
		while (html.indexOf(search)>=0){
			html=html.replace(search, image);
		}

	}
	$("#comments").html(html);
}

});