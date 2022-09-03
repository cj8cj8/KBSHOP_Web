
$(document).ready(init);	
function init() {
		
		$(window).scroll(scrollHandler);
		
	/*	$("#myShow").click(scrollHandler);
		setTimeout(function() {
			showHandler()
		}, 1000);*/		

	}
	
	function leftMenuHnadler() {

		$("#leftmenu1").fadeIn(1000);
	}

	function showHandler() {

		$(".menu1").slideDown(300);
	}

	function scrollHandler() {

		var scrollDist = $(window).scrollTop();

		if (scrollDist == 0) {

			$(".menu2").slideDown(500);
			
			
			
		} else {
			$(".menu2").slideUp(200);		
						
		}
		if(scrollDist >= 50) {
			
		$("#headertest").slideDown(300);
		
		}else{
	
			
			$("#headertest").fadeOut(30);
			
		}
	}
var countNew;
$(document).ready(function() {
    $('#leftmenu').fadeOut(300);
     $("html").removeClass("noscroll");
     $("#leftmenu2").animate({left:"-350px"},300)
} );

$('#leftbtn').click(function () {
  $('#leftmenu').fadeIn(300);
    $("html").addClass("noscroll");
     $("#leftmenu2").animate({left:"0px"},300)
    countNew = 0;
    
});
function imgReserveClick (e) {
    $('#leftmenu').fadeIn(300);
     $("html").addClass("noscroll");
      $("#leftmenu2").animate({left:"0px"},300)
     

    countNew = 0;
}
$('#leftCloseBtn').click(function () {
    $('#leftmenu').fadeOut(300);
     $("html").removeClass("noscroll");
     $("#leftmenu2").animate({left:"-350px"},300)
});

$(document).click(function (event) {
    countNew++;

    if (countNew > 1 && !$(event.target).closest('#leftmenu2').length&&!$(event.target).closest('#menu').length) {
        if ($('#leftmenu2').is(":visible")) {
            $('#leftmenu').fadeOut(300);
             $("#leftmenu2").animate({left:"-350px"},300)
             $("html").removeClass("noscroll");
            countNew = 0;
        }
    }
   
});

