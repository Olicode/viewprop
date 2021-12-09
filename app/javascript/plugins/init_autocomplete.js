import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('location-input-homepage');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };
