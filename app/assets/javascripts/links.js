
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
      <div class="card link-card" id="${link.id}" >
        <div class="card-content">
          <span class="card-title">${link.title}</span>
            <p>
              <a href ="${link.url}">${link.url}</a>
              <p class='read-status'>Read: ${link.read}</p>
            </p>
        </div>
      </div>
    </div>`

    $('#link-list .row').prepend(linkHtml)

    if (link.read == true) {
      let readOrNot = `<div class="card-action">
        <button class="mark-as-unread" data-id="${link.id}">Mark as unread</button>
        <form action="/links/${link.id}/edit" method="get">
          <input type="submit" value="Edit" class="edit-link"/>
        </form>
      </div>`
      $(`#${link.id}`).append(readOrNot)
      $(`#${link.id}`).addClass('green lighten-1')

    } else {
      let readOrNot = `<div class="card-action">
        <button class="mark-as-read" data-id="${link.id}">Mark as read</button>
        <form action="/links/${link.id}/edit" method="get">
          <input type="submit" value="Edit" class="edit-link"/>
        </form>
      </div>`
      $(`#${link.id}`).append(readOrNot)
    }
  })
}

function filterLinks() {
  $('#filter-links').keyup( function () {

    $('.link-card').each( function(index, link) {
      let inputVal = $('#filter-links').val().toLowerCase()
      let cardTitle = $(link).find('.card-title').text().toLowerCase()
      let cardUrl = $(link).find('a').text().toLowerCase()

      if (cardTitle.includes(inputVal) || cardUrl.includes(inputVal)){
        $(link).show()
      } else {
        $(link).hide()
      }
    })
  })
}



$(document).ready(function(){
  bindLinkSubmit()

  loadAllLinks()

  filterLinks()
});
