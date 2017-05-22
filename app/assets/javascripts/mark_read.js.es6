$( document ).ready(function(){
  $("body").on("click", ".mark-as-read", markAsRead)
  
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

function updateLinkStatus(link) {
  $(`#${link.id} .read-status`).text("Read: true")
  $(`#${link.id}`).addClass('green lighten-1')
  $(`#${link.id} .card-action`).empty().remove()

  let changeToRead = `<div class="card-action">
    <button class="mark-as-unread" data-id="${link.id}">Mark as unread</button>
    <form action="/links/${link.id}/edit" method="get">
      <input type="submit" value="Edit" class="edit-link"/>
    </form>
  </div>`

  $(`#${link.id}`).append(changeToRead)
}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}
