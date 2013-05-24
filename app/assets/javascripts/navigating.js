var id=0;
var lastScrollTop=0;
var ignoreScroll=false;

$(document).ready(function () {

    $(window).scroll(function(e){

        if(ignoreScroll==true){
            ignoreScroll=false;
            return;
        }
        var scroll=$(this).scrollTop();
        if($("#gags li:first").length>0)
        var liHeights=$("#gags li:first").position().top;
    else
        return;

        $('#gags li').each(function(index){
            if($(this).position().top>=scroll){
                id=index;
                return false;
            }

        });
        
    });
    
    $(document).keydown(function(e) {
        ignoreScroll=true;
        if(e.which==74){
            id++;
            var current=$('#gag'+id);
            if(current.length==0)
                id--;
            position=current.position();
            $('html, body').animate({
             scrollTop: position.top-50
         }, 1);
            
        }
        if(e.which==75){
            id--;
            if(id<0)
                id=0;
            var current=$('#gag'+id);
            if(current.length==0)
                id++;
            position=current.position();
            $('html, body').animate({
             scrollTop: position.top-50
         }, 1);   
        }

        if(e.which==76){
            if($('#like'+id).length>0)
                $('#like'+id).trigger("submit");
            if($('#like-1').length>0){
                $('#like-1').attr("id", "like"+id);
            }
        }
        if(e.which==72){
            if($('#dislike'+id).length>0)
             $('#dislike'+id).trigger("submit");
            if($('#dislike-1').length>0){
             $('#dislike-1').attr("id", "dislike"+id);
        }
    }

});




});


        
