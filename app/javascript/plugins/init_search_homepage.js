

const initSearchHomepage = () => {
  const input = document.getElementById('location-input-homepage')
  input.addEventListener('keyup', getCity)
  console.log(input)
}

const getCity = (e) => {
  if (e.keyCode === 13) {
    e.preventDefault();
    const searchTerm = e.currentTarget.value
  }
}

export { initSearchHomepage }
