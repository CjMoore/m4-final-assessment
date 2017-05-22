
function printLink(data) {
  $('#link-list .row').prepend(data)
  $('#url').val('')
  $('#title').val('')
}

function addLink() {
  const linkData = {link: {url: $('#url').val(), title: $('#title').val() } }

  $.ajax ({
    url: '/links',
    method: 'POST',
    data: linkData
  }).then( (data) => printLink(data))
  .fail( (error) => {
    console.error(error)
  });
}

function bindLinkSubmit() {
  $('#link-form').on('click', "#create-link", (event) => addLink())
}

function loadAllLinks() {
  $.ajax({
    url: '/api/v1/links',
    method: 'GET'
  }).then( (data) => printAllLinks(data))
  .fail( (error) => {
    console.error(error)
  });
}

function printAllLinks(data) {
  
}

$(document).ready(function(){
  bindLinkSubmit()

  loadAllLinks()
});
