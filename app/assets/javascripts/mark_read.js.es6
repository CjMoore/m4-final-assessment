$( document ).ready(function(){
  $("body").on("click", ".mark-as-read", markAsRead)
  $("body").on("click", ".mark-as-unread", markAsUnread)
})

function markAsRead(e) {
  e.preventDefault();

  const linkId = $(this).data('id')

  $.ajax({
    type: "PATCH",
    url: "/api/v1/links/" + linkId,
    data: { read: true },
  }).then(updateLinkStatus)
    .fail(displayFailure);
}

function markAsUnread(e) {
  e.preventDefault();

  const linkId = $(this).data('id')

  $.ajax({
    type: "PATCH",
    url: "/api/v1/links/" + linkId,
    data: { read: false },
  }).then(updateLinkStatus)
    .fail(displayFailure);
}

function updateLinkStatus(link) {
  if (link.read == true) {
    $(`#${link.id} .read-status`).text("Read: true")
    $(`#${link.id}`).addClass('green lighten-1')
    $(`#${link.id} .card-action`).empty().remove()

    let changeToRead = `<div class="card-action">
    <button class="mark-as-unread btn cyan lighten-4" data-id="${link.id}">Mark as unread</button>
    <form action="/links/${link.id}/edit" method="get">
    <input type="submit" value="Edit" class="edit-link deep-orange lighten-3 btn"/>
    </form>
    </div>`

    $(`#${link.id}`).append(changeToRead)
    sendToHotReads(link)

  } else {

    $(`#${link.id} .read-status`).text("Read: false")
    $(`#${link.id}`).removeClass('green lighten-1')
    $(`#${link.id} .card-action`).empty().remove()

    let changeToUnread = `<div class="card-action">
    <button class="mark-as-read btn purple lighten-3" data-id="${link.id}">Mark as read</button>
    <form action="/links/${link.id}/edit" method="get">
    <input type="submit" value="Edit" class="edit-link deep-orange lighten-3 btn"/>
    </form>
    </div>`

    $(`#${link.id}`).append(changeToUnread)
  }
}

function sendToHotReads(link) {
  debugger
  $.ajax({
    type: "POST",
    url: "http://localhost:3000/api/v1/links",
    data: link
  }).done(updateHotRead(data))
  .fail(displayFailure);
}

// https://hot-reads-cjm.herokuapp.com/api/v1/links
function updateHotRead(data){
  debugger
}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}
