
function printLink(data) {
  debugger
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

$(document).ready(function(){
  bindLinkSubmit()
});
