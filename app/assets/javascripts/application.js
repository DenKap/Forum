//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on("page:change", function(){
	setTimeout(function(){
	    $('#notification').hide();
	}, 2500);
})

/* $(document).on("page:fetch", function(){
	console.log("i'm thinking");
});

$(document).on("page:receive", function(){
	console.log("i'm herehere");
}); */