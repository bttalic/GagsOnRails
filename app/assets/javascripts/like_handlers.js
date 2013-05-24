/*$(document).ready(function(){
	$('button').click(function(){
		var id=this.id;
		if(id.indexOf("up")>=0 || id.indexOf("down")>=0 ){

				var button=$('#'+id);
				if(button.hasClass("not-clicked-like-dislike")==true){
					button.removeClass("not-clicked-like-dislike");
				}
				else{
					button.addClass("not-clicked-like-dislike");
				}

			var num_id;
			var index=id.indexOf("up");
			if(index<0){
				index=id.substring(0,id.indexOf("down"));
			}
			num_id=id.substring(0,index);
			$('#votes'+num_id).html('<%= @gag.votes_up %>' );

		}
	});
});*/