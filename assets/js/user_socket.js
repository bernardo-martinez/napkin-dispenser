const newBtn = document.querySelector( '#new' );

newBtn.addEventListener('click', newNapkin);

function newNapkin() {
  const uuid = crypto.randomUUID()
  location.href = "/" + uuid
}