$(document).ready(function () {

	$('#switch_to_microposts').click(function(event){
		event.preventDefault();

		$('#gags').removeClass().addClass('hidden');
		$('#microposts').removeClass();
	});

	$('#switch_to_gags').click(function(event){
		event.preventDefault();

		$('#microposts').removeClass().addClass('hidden');
		$('#gags').removeClass();
	});
    //jquery
    var pathname = String($(location).attr('href'));
    
if(pathname.indexOf("type")>0){
	var type=pathname.substring(pathname.indexOf('type')+5, pathname.length );
	if(type=="gags"){
		$('#microposts').removeClass().addClass('hidden');
		$('#gags').removeClass();
	}
	else if(type=="micro"){
		$('#gags').removeClass().addClass('hidden');
		$('#microposts').removeClass();
	}
}
   
 // to show it in an alert window
});