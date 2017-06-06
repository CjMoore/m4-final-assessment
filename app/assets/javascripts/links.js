
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
  }).then( (data) => printAllLinks(data, getHotReads()))
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
        <button class="mark-as-unread btn cyan lighten-4" data-id="${link.id}">Mark as unread</button>
        <form action="/links/${link.id}/edit" method="get">
          <input type="submit" value="Edit" class="edit-link deep-orange lighten-3 btn"/>
        </form>
      </div>`
      $(`#${link.id}`).append(readOrNot)
      $(`#${link.id}`).addClass('green lighten-1')

    } else {
      let readOrNot = `<div class="card-action">
        <button class="mark-as-read btn purple lighten-3" data-id="${link.id}">Mark as read</button>
        <form action="/links/${link.id}/edit" method="get">
          <input type="submit" value="Edit" class="edit-link deep-orange lighten-3 btn"/>
        </form>
      </div>`
      $(`#${link.id}`).append(readOrNot)
    }
  })
}

function getHotReads() {
  $.ajax({
    method: 'GET',
    url: 'https://hot-reads-cjm.herokuapp.com/api/v1/links'
  }).then((data) => addHot(data))
  .fail( (error) => {
    console.error(error)
  });
}

function addHot(data) {
  var hot_links = getHotReadsUrls(data)
  $('.link-card').each( function(index, link) {
    let cardUrl = $(link).find('a').text().toLowerCase()
    if (hot_links.includes(cardUrl)) {
      $(link).find('.is-hot').remove()
      $(link).find('.card-title').prepend('<h5 class="is-hot">Hot!</h5>')
    } else {
      $(link).find('.is-hot').remove()
    }
    if (hot_links[0] == cardUrl) {
      $(link).find('.is-hot').text('Top!')
    }
  })
}

function getHotReadsUrls(hotLinks){
  var urls = []
  hotLinks.forEach( function(link) {
    urls.push(link.url)
  })
  return urls
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

function showRead() {
  $('#show-read').on('click', function(event) {
    $('.link-card').each( function(index, link) {
      let readVal = $(link).find('.read-status').text()
      if(readVal.includes("true")) {
        $(link).show()
      } else {
        $(link).hide()
      }
    })
  })
}

function showUnread() {
  $('#show-unread').on('click', function(event) {
    $('.link-card').each( function(index, link) {
      let readVal = $(link).find('.read-status').text()
      if(readVal.includes("false")) {
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

  showRead()

  showUnread()
});
