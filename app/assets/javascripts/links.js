
function printLink(data) {
  if (data.includes('.error') ){

  } else {
    $('#link-list .row').prepend(data)
    $('#url').val('')
    $('#title').val('')
    $('.error').empty()
  }
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
  data.forEach( (link) => {
    let linkHtml = `<div class="col s4">
      <div class="card">
        <div class="card-content">
          <span class="card-title">${link.title}</span>
            <p>
              <a href ="${link.url}">${link.url}</a>
              <p>Read: ${link.read}</p>
            </p>
        </div>
        <div class="card-action">
          <a href="#">Mark as read</a>
          <a href="#">Edit</a>
        </div>
      </div>
    </div>`
    $('#link-list .row').prepend(linkHtml)
  })
}

$(document).ready(function(){
  bindLinkSubmit()

  loadAllLinks()
});
