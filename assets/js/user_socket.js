const newBtn = document.querySelector( '#new' );

newBtn.addEventListener('click', newNapkin);

const paintCanvas = document.querySelector( '#canvas' );
const context = paintCanvas.getContext( '2d' );
context.lineCap = 'round';

function newNapkin() {
  const uuid = crypto.randomUUID()
  location.href = "/" + uuid
}