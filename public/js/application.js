$(document).ready(function(){
	$('#search').on('submit', getSearch)
	$(document).on('click', 'img.spring', favoriteSpring);
});

function getSearch(evt){
	evt.preventDefault();
	var formData = $('#search').serialize();
	$.ajax({
		url: '/search',
		type: 'GET',
		data: formData
	}).done(displaySearch)
}

function displaySearch(reply_from_server){
	$('#snippets').remove();
	$('input').text();
	$('header').append(reply_from_server)
}


// ----------------------------------------

function favoriteSpring(evt){
	console.log('corgi');
	evt.preventDefault();
	data = $(this).attr('id')
	console.log(data)
	$.ajax({
		url: '/favorite/new',
		type: 'post',
		data: data
	}).done(createFav)
}

function createFav(reply){
	$('#'+data).after(reply);
}